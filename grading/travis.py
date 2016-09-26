import functools
import json
import re
import requests


TEST_DELIMITER = '<MQkrXV>'

pattern = "%s[^{]+([{].*[}]{2,3}) " % TEST_DELIMITER
RESULTS_REGEX = re.compile(pattern, re.MULTILINE)


class Build:
    def __init__(self, repo, build_id):
        self.repo = repo
        self.build_id = build_id

    def url(self):
        return "https://travis-ci.org/{}/builds/{:d}".format(self.repo, self.build_id)

    @functools.lru_cache()
    def build_data(self):
        url = "https://api.travis-ci.org/repos/{}/builds?ids={:d}".format(self.repo, self.build_id)
        headers = {'User-Agent': 'MyClient/1.0.0', 'Accept': 'application/vnd.travis-ci.2+json'}
        response = requests.get(url, headers=headers)
        data = response.text
        return json.loads(data)

    @functools.lru_cache()
    def job_id(self):
        builds = self.build_data()['builds']
        return int(builds[0]['job_ids'][0])

    @functools.lru_cache()
    def log_url(self):
        job_id = self.job_id()
        if isinstance(job_id, int) is False:
            pytest_report = {}
            print("wrong S3 id for user %s." % self.user())
            return pytest_report
        return "https://s3.amazonaws.com/archive.travis-ci.org/jobs/{:d}/log.txt".format(job_id)

    @functools.lru_cache()
    def log(self):
        """Retrieves the raw log data from S3."""
        url = self.log_url()
        response = requests.get(url)
        return response.text

    @functools.lru_cache()
    def pytest_report(self):
        log_data = self.log().replace('\n', ' ').replace('\r', ' ')
        matches = RESULTS_REGEX.findall(log_data)
        if len(matches) == 1:
            report = matches[0]
            return json.loads(report)
        else:
            return None
