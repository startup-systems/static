from scorer import Scorer


def grade(pull_request):
    print(pull_request.travis_build().url())
    pull_request.check_test_modifications()

    scorer = Scorer(pull_request)
    score = scorer.compute()
    print("score:", score)

    return score
