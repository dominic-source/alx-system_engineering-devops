#!/usr/bin/python3
"""This module helps to list all hot post of reddit
product
"""

import requests
import sys


def count_words(subreddit, word_list, hot_object={}, start=True, after=''):
    """count all hot post"""
    url = 'https://www.reddit.com/r/{}/hot.json?after={}'.format(
                                                                subreddit,
                                                                after)
    header = {'User-Agent': 'adaDASS'}

    res = requests.get(url, allow_redirects=False, headers=header)
    result = None
    words = [word.lower for word in word_list]
    if res.status_code == requests.codes.ok:
        result = res.json()
        for child in result.get('data').get('children'):
            title = child.get('data').get('title')
            title_low = title.lower()
            if title_low in words:
                for data in words:
                    if data in title_low.split():
                        hot_object[data] += hot_object.get(data, 0)
        next_page = result.get('data').get('after')
        count_words(subreddit, word_list, hot_object,
                    start=False, after=next_page)
    elif result is None:
        return None
    if start:
        if hot_object:
            sorted_object = {key: hot_object[key]
                             for key in sorted(hot_objects)
                             if hot_object[key] != 0}
            print(sorted_object)
        else:
            print


if __name__ == '__main__':
    count_words(sys.argv[1], ['java', 'python'])
