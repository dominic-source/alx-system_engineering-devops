#!/usr/bin/python3
"""This module helps to list top 10 hot post of reddit
product
"""

import requests
import sys


def top_ten(subreddit):
    """cound subscribers"""
    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    header = {'User-Agent': 'web api server/1.0'}
    res = requests.get(url, allow_redirects=False, headers=header)
    if res.status_code == requests.codes.ok:
        result = res.json()
        for title in range(10):
            print(result.
                  get('data').
                  get('children')[title].
                  get('data').
                  get('title'))
    else:
        print(None)


if __name__ == '__main__':
    top_ten(sys.argv[1])
