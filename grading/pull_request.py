import functools
import github
import travis


class PullRequest:
    def __init__(self, data):
        self.data = data

    def sha(self):
        return self.data['head']['sha']

    def updated_at(self):
        return self.data['updated_at']

    def user(self):
        return self.data['user']['login'].lower()

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
    def modified_files_data(self):
        url = "https://api.github.com/repos/{}/pulls/{:d}/files".format(self.base_repo(), self.data['number'])
        return github.api_request(url)

    @functools.lru_cache()
    def modified_files(self):
        files = self.modified_files_data()
        return map(lambda x: x['filename'], files)

    @functools.lru_cache()
    def travis_build(self):
        repo = self.base_repo()
        build_id = self.travis_build_id()
        return travis.Build(repo, build_id)
