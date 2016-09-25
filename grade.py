
# coding: utf-8
"""Python script to automatically grade based on pull-requests."""


import json
import re
import sys
import requests

REPO = "startup-systems/static"
GIT_PULLS = "https://api.github.com/repos/%s/pulls" % REPO
GIT_STATUSES_FROM_SHA = "https://api.github.com/repos/" + REPO + "/commits/%s/statuses"
GIT_COMMIT_FROM_SHA = "https://api.github.com/repos/" + REPO + "/commits/%s"
TRAVIS_LOG_FROM_ID = "https://api.travis-ci.org/jobs/%d/logs"
TRAVIS_LOG_S3 = "https://s3.amazonaws.com/archive.travis-ci.org/jobs/%d/log.txt"
TRAVIS_BUILD_URL = "https://api.travis-ci.org/repos/" + REPO + "/builds?ids=%d"

GIT_USER = 'sahuguet'
GITHUB_TOKEN = 'd621ee8931b06586b015266ea682a6bbb3730d2f'


def get_travis_url_from_git(sha):
    """Grabs the Travis URL from the git commit data."""
    url = GIT_STATUSES_FROM_SHA % sha
    print >> sys.stderr, "status:", url
    response = requests.get(url, auth=('sahuguet', GITHUB_TOKEN))
    data = response.text
    statuses = json.loads(data)
    for item in statuses:
        if item['context'] == "continuous-integration/travis-ci/pr":
            return item['target_url']
    return None


def get_modified_files_from_git(sha):
    """Grabs the set of modified files from the git commit data."""
    url = GIT_COMMIT_FROM_SHA % sha
    #print >> sys.stderr, url
    response = requests.get(url, auth=('sahuguet', GITHUB_TOKEN))
    data = response.text
    commit = json.loads(data)
    return map(lambda x: x['filename'], commit['files'])


def get_pytest_report_from_s3(job_id, user):
    """Retrieves the raw log data from S3, based on job id."""
    if isinstance(job_id, int) is False:
        pytest_report = {}
        print >> sys.stderr, "wrong S3 id for user %s." % user
        return pytest_report
    url = TRAVIS_LOG_S3 % int(job_id)
    print >> sys.stderr, url
    response = requests.get(url)
    log_data = response.text.replace('\n', ' ').replace('\r', ' ')
    pattern = re.compile('<MQkrXV>[^{]+([{].*[}]{2,3}) ', re.MULTILINE)
    match = pattern.search(log_data)
    if match:
        pytest_report = match.group(1)
    else:
        pytest_report = {}
    return pytest_report


def get_travis_jobid(build_id):
    url = TRAVIS_BUILD_URL % build_id
    print >> sys.stderr, url
    headers = {'User-Agent': 'MyClient/1.0.0', 'Accept': 'application/vnd.travis-ci.2+json'}
    response = requests.get(url, headers=headers)
    data = response.text
    builds = json.loads(data)['builds']
    print >> sys.stderr, json.dumps(builds, indent=2, sort_keys=True)
    return builds[0]['job_ids'][0]


if __name__ == '__main__':
    # We get all the pull-requests from the repo.
    response = requests.get(GIT_PULLS, auth=('sahuguet', GITHUB_TOKEN))
    pull_requests = json.loads(response.text)
    print >> sys.stderr, "%d submission(s)." % len(pull_requests)

    # To store all submissions
    SUBMISSIONS = []

    for r in pull_requests[0:]:
        user = r['user']['login']
        print >> sys.stderr, user
        timestamp = r['updated_at']
        sha = r['head']['sha']

        # Get Travis data from Git pull-request.
        travis_data = get_travis_url_from_git(sha)

        modified_files = get_modified_files_from_git(sha)
        build_id = int(travis_data.split('/')[-1])
        print >> sys.stderr, "Build_id %s for user %s." % (build_id, user)

        # Get TravisCI jobid from build_id.
        job_id = get_travis_jobid(build_id)
        print >> sys.stderr, job_id

        SUBMISSIONS.append({'user': user, 'sha': sha, 'timestamp': timestamp,
                            'modified_files': modified_files,
                            'travis': travis_data,
                            'travis_job_id': job_id,
                            'pytest_report': get_pytest_report_from_s3(job_id, user)})  # from S3.

    # We output everything.
    print json.dumps(SUBMISSIONS, sort_keys=True, indent=2,)
