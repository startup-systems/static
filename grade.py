# coding: utf-8
"""Python script to automatically grade based on pull-requests. Usage:

    python grade.py > grades.json

"""

import json
import re
import sys
import requests

REPO = "startup-systems/static"
GIT_PULLS = "https://api.github.com/repos/%s/pulls" % REPO
GIT_STATUSES_FROM_SHA = "https://api.github.com/repos/" + REPO + "/commits/%s/statuses"
GIT_COMMIT_FROM_SHA = "https://api.github.com/repos/" + REPO + "/commits/%s"
TRAVIS_LOG_S3 = "https://s3.amazonaws.com/archive.travis-ci.org/jobs/%d/log.txt"
TRAVIS_BUILD_URL = "https://api.travis-ci.org/repos/" + REPO + "/builds?ids=%d"

GIT_USER = 'sahuguet'
# this provides read-only access, and is thus safe to commit
GITHUB_TOKEN = 'd621ee8931b06586b015266ea682a6bbb3730d2f'

class PullRequest:
    def __init__(self, data):
        self.data = data

    def sha(self):
        return self.data['head']['sha']

    def updated_at(self):
        return self.data['updated_at']

    def user(self):
        return self.data['user']['login']

    def travis_url(self):
        """Grabs the Travis URL from the git commit data."""
        url = GIT_STATUSES_FROM_SHA % self.sha()
        print("status:", url, file=sys.stderr)
        response = requests.get(url, auth=('sahuguet', GITHUB_TOKEN))
        data = response.text
        statuses = json.loads(data)
        for item in statuses:
            if item['context'] == "continuous-integration/travis-ci/pr":
                return item['target_url']
        return None

    def modified_files(self):
        """Grabs the set of modified files from the git commit data."""
        url = GIT_COMMIT_FROM_SHA % self.sha()
        # print(url, file=sys.stderr)
        response = requests.get(url, auth=('sahuguet', GITHUB_TOKEN))
        data = response.text
        commit = json.loads(data)
        return map(lambda x: x['filename'], commit['files'])

def get_pytest_report_from_s3(job_id, user):
    """Retrieves the raw log data from S3, based on job id."""
    if isinstance(job_id, int) is False:
        pytest_report = {}
        print("wrong S3 id for user %s." % user, file=sys.stderr)
        return pytest_report
    url = TRAVIS_LOG_S3 % int(job_id)
    print(url, file=sys.stderr)
    response = requests.get(url)
    log_data = response.text.replace('\n', ' ').replace('\r', ' ')
    pattern = re.compile('<MQkrXV>[^{]+([{].*[}]{2,3}) ', re.MULTILINE)
    match = pattern.search(log_data)
    # TODO ensure it's only found once
    if match:
        pytest_report = match.group(1)
    else:
        pytest_report = {}
    return pytest_report


def get_travis_jobid(build_id):
    url = TRAVIS_BUILD_URL % build_id
    print(url, file=sys.stderr)
    headers = {'User-Agent': 'MyClient/1.0.0', 'Accept': 'application/vnd.travis-ci.2+json'}
    response = requests.get(url, headers=headers)
    data = response.text
    builds = json.loads(data)['builds']
    print(json.dumps(builds, indent=2, sort_keys=True), file=sys.stderr)
    return builds[0]['job_ids'][0]


if __name__ == '__main__':
    # We get all the pull-requests from the repo.
    response = requests.get(GIT_PULLS, auth=('sahuguet', GITHUB_TOKEN))
    pull_requests = json.loads(response.text)
    print("%d submission(s)." % len(pull_requests), file=sys.stderr)

    # To store all submissions
    SUBMISSIONS = []

    for r in pull_requests[0:]:
        pr = PullRequest(r)
        user = pr.user()
        print(user, file=sys.stderr)
        sha = pr.sha()

        # Get Travis data from Git pull-request.
        travis_data = pr.travis_url()
        build_id = int(travis_data.split('/')[-1])
        print("Build_id %s for user %s." % (build_id, user), file=sys.stderr)

        # Get TravisCI jobid from build_id.
        job_id = get_travis_jobid(build_id)
        print(job_id, file=sys.stderr)

        modified_files = pr.modified_files()

        SUBMISSIONS.append({'user': user, 'sha': sha, 'timestamp': pr.updated_at(),
                            'modified_files': list(modified_files),
                            'travis': travis_data,
                            'travis_job_id': job_id,
                            'pytest_report': get_pytest_report_from_s3(job_id, user)})  # from S3.

    # We output everything.
    results = json.dumps(SUBMISSIONS, sort_keys=True, indent=2)
    print(results)
