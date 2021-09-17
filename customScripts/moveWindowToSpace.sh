#!/bin/zsh

inputSpaceNumber=$1

# get the array of current spaces 
currentlyFocusedDisplaySpaces=($(yabai -m query --displays --display | jq -re '.spaces' | tr -d '[],')) 
# tr removes square brackets and commas. placing () outside the statement converts it to an array

spaceToMove=$currentlyFocusedDisplaySpaces[$inputSpaceNumber]
currentSpace=$(yabai -m query --spaces --space | jq -re '.index')

# Already at the correct space, don't move
if [[ "$spaceToMove" -eq "$currentSpace" ]]; then
	exit 0
fi

currentWindow=$(yabai -m query --windows --window | jq -re ".id")

focusWindow() {
	sleep .1 # animation because of SIP
	echo $focusWindow
	$(yabai -m window --focus $1)
}

$(yabai -m window --space $spaceToMove; focusWindow $currentWindow)
