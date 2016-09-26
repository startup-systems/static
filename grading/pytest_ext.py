import pytest


class TestCollector:
    # http://doc.pytest.org/en/latest/writing_plugins.html#_pytest.hookspec.pytest_collection_modifyitems
    def pytest_collection_modifyitems(self, config, items):
        self.items = items


class TestDef:
    def __init__(self, test):
        self.test_id = test.nodeid
        self.extra_credit = 'xfail' in test.keywords

        score_config = test.keywords.get('score')
        if score_config is None:
            self.score = 0
        else:
            self.score = score_config.args[0]

    @classmethod
    def collect(cls, tests_path):
        collector = TestCollector()
        pytest.main(['--collect-only', '--quiet', '--quiet', tests_path], plugins=[collector])
        return [cls(test) for test in collector.items]
