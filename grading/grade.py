# coding: utf-8
"""Python script to automatically grade based on pull requests."""

import csv
import github
import sys
from pull_request import PullRequest
import requests
from scorer import Scorer
from student import Student

REPO = "startup-systems/static"
GIT_PULLS = "https://api.github.com/repos/%s/pulls" % REPO

SURVEY_DATA_PATH = sys.argv[1]
OUTPUT_PATH = sys.argv[2]


if __name__ == '__main__':
    # We get all the pull requests from the repo.
    # TODO make sure to paginate
    pull_requests = github.api_request(GIT_PULLS)
    print("%d submission(s)." % len(pull_requests))

    students_by_github_username = Student.all_by_github_username(SURVEY_DATA_PATH)

    # TODO include (zero) grades for students who don't have an open pull request
    # TODO if a student has multiple pull requests, use the more recent one
    with open(OUTPUT_PATH, 'w', newline='') as csvfile:
        resultwriter = csv.writer(csvfile)
        # this matches the grading spreadsheet template provided by CMS
        resultwriter.writerow(["NetID", "Grade", "Add Comments"])

        # TODO take out the limit
        for r in pull_requests[0:2]:
            pr = PullRequest(r)

            github_username = pr.user()
            print(github_username, end=': ')

            student = students_by_github_username.get(github_username)
            if student == None:
                print("not enrolled.")
                continue
            print(pr.travis_log_url())
            # TODO ensure test files werent modified

            scorer = Scorer(pr)
            scorer.compute()

            net_id = student.net_id
            # TODO put in actual score
            resultwriter.writerow([net_id, 1, ""])
