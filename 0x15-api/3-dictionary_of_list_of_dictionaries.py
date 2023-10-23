#!/usr/bin/python3
"""This module contains a function used to get information from
an API end point and stores it in a json file
"""

import json
import requests
import sys


def call_me():
    """The function get info from API"""
    try:
        # construct url for the api transaction
        url_user = f"https://jsonplaceholder.typicode.com/users/"

        # Make the request for users
        res = requests.get(url_user).json()
        filename = "todo_all_employees.json"

        # Open the file for write into json file
        with open(filename, "w") as jsonfile:
            my_data = {}
            # Loop for each user
            for user in res:
                user_id = user.get("id")
                user_username = user.get("username")
                my_data[user_id] = []

                # contruct url for each user's todo and make a request
                url = "https://jsonplaceholder.typicode.com/users/{}/todos". \
                      format(user_id)
                res_t = requests.get(url).json()

                # loop for each user's todos
                for data in res_t:
                    my_data[user_id].append({
                        "username": user_username,
                        "task": data.get("title"),
                        "completed": data.get("completed"),
                        })
            json.dump(my_data, jsonfile)

    except ValueError:
        arg = None


if __name__ == "__main__":
    call_me()
