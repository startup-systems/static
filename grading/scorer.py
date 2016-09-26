from pytest_ext import TestDef


CODE_CLIMATE_SCORE = 5
TESTS = TestDef.collect('..')
TOTAL_BASE_SCORE = 100


def verify_totals():
    """Ensure that the base scores sum to {}.""".format(TOTAL_BASE_SCORE)
    total = CODE_CLIMATE_SCORE
    for test_def in TESTS:
        if not test_def.extra_credit:
            total += test_def.score

    if total != TOTAL_BASE_SCORE:
        raise ValueError("Scores for non-extra-credit tests: {}".format(total))

verify_totals()


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
        pytest_report = self.pull_request.travis_build().pytest_report()
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
