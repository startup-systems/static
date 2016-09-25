# coding: utf-8
"""Python script to automatically grade based on pull requests."""

import github
import json
import sys
from pull_request import PullRequest
import requests
from student import Student

REPO = "startup-systems/static"
GIT_PULLS = "https://api.github.com/repos/%s/pulls" % REPO

SURVEY_DATA_PATH = sys.argv[1]


if __name__ == '__main__':
    # We get all the pull-requests from the repo.
    # TODO make sure to paginate
    pull_requests = github.api_request(GIT_PULLS)
    print("%d submission(s)." % len(pull_requests), file=sys.stderr)

    students_by_github_username = Student.all_by_github_username(SURVEY_DATA_PATH)
    SUBMISSIONS = []

    # TODO take out the limit
    for r in pull_requests[0:2]:
        pr = PullRequest(r)

        user = pr.user()
        if user not in students_by_github_username:
            print("{} not enrolled.".format(user), file=sys.stderr)
            continue
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
