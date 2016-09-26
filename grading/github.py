import functools
import json
import requests


GIT_USER = 'sahuguet'
# this provides read-only access, and is thus safe to commit
GITHUB_TOKEN = 'd621ee8931b06586b015266ea682a6bbb3730d2f'


@functools.lru_cache()
def api_request(url):
    response = requests.get(url, auth=(GIT_USER, GITHUB_TOKEN))
    body = response.text
    return json.loads(body)
