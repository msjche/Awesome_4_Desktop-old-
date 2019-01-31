#!/bin/python

import json

path = "/home/msjche/.config/Google Play Music Desktop Player/json_store/playback.json"

with open(path, encoding='utf-8-sig') as json_file:
    text = json_file.read()
    json_data = json.loads(text)

    time_current = int(json_data["time"]["current"])
    time_total = int(json_data["time"]["total"])

time_progress = time_current/time_total*100
print(time_progress)
