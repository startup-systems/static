# coding: utf-8
"""Python script to automatically grade based on pull requests."""

import csv
import grader
import sys
from pull_request import PullRequest
from student import Student


SURVEY_DATA_PATH = sys.argv[1]
OUTPUT_PATH = sys.argv[2]


if __name__ == '__main__':
    pull_requests = PullRequest.all(grader.REPO)
    students_by_github_username = Student.all_by_github_username(SURVEY_DATA_PATH)

    # TODO include (zero) grades for students who don't have an open pull request
    with open(OUTPUT_PATH, 'w', newline='') as csvfile:
        resultwriter = csv.writer(csvfile)
        # this matches the grading spreadsheet template provided by CMS
        resultwriter.writerow(["NetID", "Grade", "Add Comments"])

        submitted_net_ids = set()
        for pr in pull_requests:
            print('-------')

            github_username = pr.username()
            print(github_username)

            student = students_by_github_username.get(github_username)
            if student is None:
                print("WARNING: not enrolled.")
                continue

            net_id = student.net_id
            if net_id in submitted_net_ids:
                print("WARNING: has a more recent submission")
                continue

            print(pr.url() + '/files')

            score = grader.grade(pr)
            # TODO put in reasoning for score
            resultwriter.writerow([net_id, score, ""])

            submitted_net_ids.add(net_id)

        print('-------')
        print("Number of submissions:", len(submitted_net_ids))
