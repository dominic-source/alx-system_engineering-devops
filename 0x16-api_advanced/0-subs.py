#!/usr/bin/python3
"""This module helps to get the total number of subscribers of reddit
product
"""

import requests
import sys


def number_of_subscribers(subreddit):
    """cound subscribers"""
    url = 'https://www.reddit.com/r/{}/about.json'.format(subreddit)
    header = {'User-Agent': 'web api server/1.0'}
    res = requests.get(url, allow_redirects=False, headers=header)
    if res.status_code == requests.codes.ok:
        data = res.json()
        data = data.get('data').get('subscribers')
        print(data)
    else:
        print(0)


if __name__ == '__main__':
    number_of_subscribers(sys.argv[1])
