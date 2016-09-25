# coding: utf-8
"""Python script to automatically grade based on pull-requests. Usage:

    python3 grade.py > grades.json

"""

import functools
import json
import re
import sys
import requests

REPO = "startup-systems/static"
GIT_PULLS = "https://api.github.com/repos/%s/pulls" % REPO
PULL_REQUEST_FILES_URL = "https://api.github.com/repos/" + REPO + "/pulls/%d/files"
TRAVIS_LOG_S3 = "https://s3.amazonaws.com/archive.travis-ci.org/jobs/%d/log.txt"
TRAVIS_BUILD_URL = "https://api.travis-ci.org/repos/" + REPO + "/builds?ids=%d"

GIT_USER = 'sahuguet'
# this provides read-only access, and is thus safe to commit
GITHUB_TOKEN = 'd621ee8931b06586b015266ea682a6bbb3730d2f'


@functools.lru_cache()
def github_request(url):
    response = requests.get(url, auth=(GIT_USER, GITHUB_TOKEN))
    body = response.text
    return json.loads(body)


class PullRequest:
    def __init__(self, data):
        self.data = data

    def sha(self):
        return self.data['head']['sha']

    def updated_at(self):
        return self.data['updated_at']

    def user(self):
        return self.data['user']['login']

    @functools.lru_cache()
    def statuses(self):
        return github_request(self.data['statuses_url'])

    @functools.lru_cache()
    def travis_url(self):
        """Grabs the Travis URL from the git commit data."""
        statuses = self.statuses()
        for item in statuses:
            if item['context'] == "continuous-integration/travis-ci/pr":
                return item['target_url']
        return None

    @functools.lru_cache()
    def travis_build_id(self):
        return int(self.travis_url().split('/')[-1])

    @functools.lru_cache()
    def travis_build_data(self):
        url = TRAVIS_BUILD_URL % self.travis_build_id()
        headers = {'User-Agent': 'MyClient/1.0.0', 'Accept': 'application/vnd.travis-ci.2+json'}
        response = requests.get(url, headers=headers)
        data = response.text
        return json.loads(data)

    @functools.lru_cache()
    def travis_job_id(self):
        builds = self.travis_build_data()['builds']
        return builds[0]['job_ids'][0]

    @functools.lru_cache()
    def modified_files_data(self):
        url = PULL_REQUEST_FILES_URL % self.data['number']
        return github_request(url)

    @functools.lru_cache()
    def modified_files(self):
        files = self.modified_files_data()
        return map(lambda x: x['filename'], files)

    @functools.lru_cache()
    def travis_log(self):
        """Retrieves the raw log data from S3."""
        job_id = self.travis_job_id()
        if isinstance(job_id, int) is False:
            pytest_report = {}
            print("wrong S3 id for user %s." % self.user(), file=sys.stderr)
            return pytest_report
        url = TRAVIS_LOG_S3 % int(job_id)
        print(url, file=sys.stderr)
        response = requests.get(url)
        return response.text

    @functools.lru_cache()
    def pytest_report(self):
        log_data = self.travis_log().replace('\n', ' ').replace('\r', ' ')
        pattern = re.compile('<MQkrXV>[^{]+([{].*[}]{2,3}) ', re.MULTILINE)
        match = pattern.search(log_data)
        # TODO ensure it's only found once
        if match:
            pytest_report = match.group(1)
        else:
            pytest_report = {}
        return pytest_report


if __name__ == '__main__':
    # We get all the pull-requests from the repo.
    pull_requests = github_request(GIT_PULLS)
    print("%d submission(s)." % len(pull_requests), file=sys.stderr)

    # To store all submissions
    SUBMISSIONS = []

    # TODO filter to registered users
    # TODO take out the limit
    for r in pull_requests[0:2]:
        pr = PullRequest(r)

        user = pr.user()
        print(user, file=sys.stderr)

        SUBMISSIONS.append({'user': user,
                            'sha': pr.sha(),
                            'timestamp': pr.updated_at(),
                            'modified_files': list(pr.modified_files()),
                            'travis': pr.travis_url(),
                            'travis_job_id': pr.travis_job_id(),
                            'pytest_report': pr.pytest_report()})

    # We output everything.
    results = json.dumps(SUBMISSIONS, sort_keys=True, indent=2)
    print(results)
