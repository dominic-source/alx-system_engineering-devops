#!/usr/bin/python3
"""This module houses a function that is used to get information from
an API end point
"""

import requests
import sys


def call_me():
    """The function get info from API"""
    try:
        arg = int(sys.argv[1])
        url_user = f"https://jsonplaceholder.typicode.com/users/{arg}"
        url_todo_f = "https://jsonplaceholder.typicode.com/"
        url_todo_f += f"users/{arg}/todos?completed=false"
        url_todo_t = "https://jsonplaceholder.typicode.co"
        url_todo_t += f"m/users/{arg}/todos?completed=true"

        res_u = requests.get(url_user).json()
        res_t = requests.get(url_todo_t).json()
        res_f = requests.get(url_todo_f).json()
        print("Employee {} is done with tasks({}/{}):".
              format(res_u.get("name"), len(res_t), len(res_t) + len(res_f)))
        for data in res_t:
            print("	 {}".format(data.get("title")))
    except ValueError:
        arg = None


if __name__ == "__main__":
    call_me()
