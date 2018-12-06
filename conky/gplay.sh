#!/bin/bash


#$current = "cat "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq -r '.time.current'"
$current = "$(cat "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq '.time.current')"
#$total = "cat "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq -r '.time.total'"
$total = "$(cat "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq -r '.time.total')"

$percent = $current / $total *100
printf $current, "\n", $total, $percent
