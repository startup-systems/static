import functools
import github
import json
import re
import requests


class PullRequest:
    def __init__(self, data):
        self.data = data

    def sha(self):
        return self.data['head']['sha']

    def updated_at(self):
        return self.data['updated_at']

    def user(self):
        return self.data['user']['login']

    def base_repo(self):
        return self.data['base']['repo']['full_name']

    @functools.lru_cache()
    def statuses(self):
        return github.api_request(self.data['statuses_url'])

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
        url = "https://api.travis-ci.org/repos/{}/builds?ids={:d}".format(self.base_repo(), self.travis_build_id())
        headers = {'User-Agent': 'MyClient/1.0.0', 'Accept': 'application/vnd.travis-ci.2+json'}
        response = requests.get(url, headers=headers)
        data = response.text
        return json.loads(data)

    @functools.lru_cache()
    def travis_job_id(self):
        builds = self.travis_build_data()['builds']
        return int(builds[0]['job_ids'][0])

    @functools.lru_cache()
    def modified_files_data(self):
        url = "https://api.github.com/repos/{}/pulls/{:d}/files".format(self.base_repo(), self.data['number'])
        return github.api_request(url)

    @functools.lru_cache()
    def modified_files(self):
        files = self.modified_files_data()
        return map(lambda x: x['filename'], files)

    @functools.lru_cache()
    def travis_log_url(self):
        job_id = self.travis_job_id()
        if isinstance(job_id, int) is False:
            pytest_report = {}
            print("wrong S3 id for user %s." % self.user())
            return pytest_report
        return "https://s3.amazonaws.com/archive.travis-ci.org/jobs/{:d}/log.txt".format(job_id)

    @functools.lru_cache()
    def travis_log(self):
        """Retrieves the raw log data from S3."""
        url = self.travis_log_url()
        response = requests.get(url)
        return response.text

    @functools.lru_cache()
    def pytest_report(self):
        log_data = self.travis_log().replace('\n', ' ').replace('\r', ' ')
        pattern = re.compile('<MQkrXV>[^{]+([{].*[}]{2,3}) ', re.MULTILINE)
        match = pattern.search(log_data)
        # TODO ensure it's only found once
        if match:
            report = match.group(1)
            return json.loads(report)
        else:
            return None
