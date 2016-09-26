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

SURVEY_DATA_PATH = sys.argv[1]
OUTPUT_PATH = sys.argv[2]


def grade(pr):
    print(pr.travis_build().url())
    pr.check_test_modifications()

    scorer = Scorer(pr)
    score = scorer.compute()
    print("score:", score)

    return score

if __name__ == '__main__':
    pull_requests = PullRequest.all(REPO)
    students_by_github_username = Student.all_by_github_username(SURVEY_DATA_PATH)

    # TODO include (zero) grades for students who don't have an open pull request
    # TODO if a student has multiple pull requests, use the more recent one
    with open(OUTPUT_PATH, 'w', newline='') as csvfile:
        resultwriter = csv.writer(csvfile)
        # this matches the grading spreadsheet template provided by CMS
        resultwriter.writerow(["NetID", "Grade", "Add Comments"])

        num_submissions = 0
        for pr in pull_requests:
            print('-------')

            github_username = pr.username()
            print(github_username)

            student = students_by_github_username.get(github_username)
            if student is None:
                print("not enrolled.")
                continue

            print(pr.url() + '/files')

            net_id = student.net_id
            score = grade(pr)
            # TODO put in reasoning for score
            resultwriter.writerow([net_id, score, ""])

            num_submissions += 1

        print('-------')
        print("Number of submissions:", num_submissions)
