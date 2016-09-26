import functools
import json
import requests


GIT_USER = 'sahuguet'
# this provides read-only access, and is thus safe to commit
GITHUB_TOKEN = 'd621ee8931b06586b015266ea682a6bbb3730d2f'


@functools.lru_cache()
def raw_api_request(url):
    return requests.get(url, auth=(GIT_USER, GITHUB_TOKEN))


@functools.lru_cache()
def api_request(url):
    response = raw_api_request(url)
    body = response.text
    return json.loads(body)


def iter_request(url):
    """Generator for GitHub API requests who respond with a `Link` header."""
    response = raw_api_request(url)

    body = response.text
    data_list = json.loads(body)
    for item in data_list:
        yield item

    # http://docs.python-requests.org/en/master/user/advanced/#link-headers
    next_dict = response.links.get('next')
    if next_dict is not None:
        next_url = next_dict['url']
        data_list = iter_request(next_url)
        for item in data_list:
            yield item
