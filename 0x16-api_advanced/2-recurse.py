#!/usr/bin/python3
"""This module helps to list all hot post of reddit
product
"""

import requests
import sys


def recurse(subreddit, hot_list=[], after="", start=True):
    """count all hot post"""
    url = 'https://www.reddit.com/r/{}/hot.json?after={}'.format(
                                                                subreddit,
                                                                after)
    header = {'User-Agent': 'it is v/1.1'}
    res = requests.get(url, allow_redirects=False, headers=header)
    result = None
    if res.status_code == requests.codes.ok:
        result = res.json()
        for title in result.get('data').get('children'):
            hot_list.append(title.get('data').get('title'))
        next_page = result.get('data').get('after')
        recurse(subreddit, hot_list, next_page, start=False)
    elif result is None or not hot_list:
        return None
    if start:
        return hot_list


if __name__ == '__main__':
    recurse(sys.argv[1])
