#!/bin/python

import json

path = "/home/msjche/.config/Google Play Music Desktop Player/json_store/playback.json"

#playback_file = open(path, 'r')



#time_current = 
#time_total = 

with open(path, encoding='utf-8-sig') as json_file:
    text = json_file.read()
    #json_data = json.loads(json_file)
    json_data = json.loads(text)
#    print(json_data)
    #print(text)
    time_current = int(json_data["time"]["current"])
    time_total = int(json_data["time"]["total"])
#    print(time_current)
#    print(time_total)

time_progress = time_current/time_total*100
print(time_progress)
