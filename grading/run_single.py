import github
import grader
import sys
from pull_request import PullRequest
import re


PULL_REQUEST_URL = sys.argv[1]


def create_pull_request(html_url):
    regex = re.compile('https://github\.com/([^/]+/[^/]+)/pull/(\d+)')
    match = regex.match(html_url.strip())
    if match is None:
        raise ValueError("Invalid pull request URL.")

    repo = match.group(1)
    pr_number = match.group(2)

    api_url = "https://api.github.com/repos/{}/pulls/{}".format(repo, pr_number)
    pr_data = github.api_request(api_url)
    return PullRequest(pr_data)


if __name__ == '__main__':
    pr = create_pull_request(PULL_REQUEST_URL)
    github_username = pr.username()
    print(github_username)
    grader.grade(pr)
