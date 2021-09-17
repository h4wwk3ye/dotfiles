#!/bin/zsh

displayPosition=$1

currentWindowId="$(yabai -m query --windows --window | jq -re ".id")"

if [[ "$displayPosition" == "right" ]]; then
	$(yabai -m window --display east || yabai -m window --display last)
else
	$(yabai -m window --display west || yabai -m window --display first)
fi

$(yabai -m window --focus "$currentWindowId")