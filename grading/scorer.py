from pytest_ext import TestDef

TESTS = TestDef.collect('..')
# TODO ensure scores sum to 100

class Scorer:
    # TODO check for Code Climate results
    def __init__(self, pull_request):
        self.pull_request = pull_request

    def compute(self):
        return
