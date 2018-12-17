#!/bin/python

import json
import time

path = "/home/msjche/.config/Google Play Music Desktop Player/json_store/playback.json"

with open(path, encoding='utf-8-sig') as json_file:
    text = json_file.read()
    json_data = json.loads(text)
    time_current = int(json_data["time"]["current"])
    time_total = int(json_data["time"]["total"])

time_current_minutes = time_current/1000
time_total_minutes = time_total/1000

def timer(current, total):
	minutes_current, seconds_current = divmod(current, 60)
	minutes_total, seconds_total = divmod(total, 60)
	timer_current = "{:0>2}:{:0>2}".format(int(minutes_current),int(seconds_current))
	timer_total = "{:0>2}:{:0>2}".format(int(minutes_total),int(seconds_total))
	print(timer_current + " / " + timer_total)

timer(time_current_minutes, time_total_minutes)
