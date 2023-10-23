#!/usr/bin/python3
"""This module houses a function that is used to get information from
an API end point
"""

import json
import requests
import sys


def call_me():
    """The function get info from API"""
    try:
        arg = int(sys.argv[1])i
        # construct url for the api transaction
        url_user = f"https://jsonplaceholder.typicode.com/users/{arg}"
        url_todo_t = f"https://jsonplaceholder.typicode.com/users/{arg}/todos"
        # Make the request
        res = requests.get(url_user).json()
        res_t = requests.get(url_todo_t).json()
        filename = f"{arg}.json"
        # Open the file for write into json file
        with open(filename, "w") as jsonfile:
            my_data = {res.get("id"): []}
            for data in res_t:
                my_data[res.get("id")].append({
                    "task": data.get("title"),
                    "completed": data.get("completed"),
                    "username": res.get("username")
                    })
            json.dump(my_data, jsonfile)

    except ValueError:
        arg = None


if __name__ == "__main__":
    call_me()
