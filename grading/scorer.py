from pytest_ext import TestDef

TESTS = TestDef.collect('..')
# TODO ensure scores sum to 100

class TestResult:
    def __init__(self, pytest_data):
        self.name = pytest_data['name']
        self.outcome = pytest_data['outcome'].lower()

    def passed(self):
        return self.outcome == 'passed' or self.outcome == 'xpass'

class Scorer:
    # TODO check for Code Climate results
    def __init__(self, pull_request):
        self.pull_request = pull_request

    def pytest_results(self):
        pytest_report = self.pull_request.pytest_report()
        tests = pytest_report['report']['tests']
        return [TestResult(r) for r in tests]

    def result_by_test_name(self):
        results = self.pytest_results()
        return {r.name: r for r in results}

    def compute(self):
        result_by_test_name = self.result_by_test_name()

        total_score = 0
        for test_def in TESTS:
            test_result = result_by_test_name[test_def.name]
            if test_result.passed():
                total_score += test_def.score

        return total_score
