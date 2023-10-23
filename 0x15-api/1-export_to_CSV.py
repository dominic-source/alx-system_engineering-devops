#!/usr/bin/python3
"""This module houses a function that is used to get information from
an API end point
"""

import csv
import requests
import sys


def call_me():
    """The function get info from API"""
    try:
        arg = int(sys.argv[1])
        url_user = f"https://jsonplaceholder.typicode.com/users/{arg}"
        url_todo_t = f"https://jsonplaceholder.typicode.com/users/{arg}/todos"

        res = requests.get(url_user).json()
        res_t = requests.get(url_todo_t).json()
        filename = f"{arg}.csv"
        with open(filename, "w") as csvfile:
            csv_writer = csv.writer(csvfile, quoting=csv.QUOTE_NONNUMERIC)
            for data in res_t:
                info = [str(res.get("id")), str(res.get("username")),
                        str(data.get("completed")), str(data.get("title"))]
                csv_writer.writerow(info)
    except ValueError:
        arg = None


if __name__ == "__main__":
    call_me()
