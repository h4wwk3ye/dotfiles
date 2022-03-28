#!/bin/zsh

inputSpaceNumber=$1

# get the array of current spaces 
currentlyFocusedDisplaySpaces=($(yabai -m query --displays --display | jq -re '.spaces' | tr -d '[],')) 
# tr removes square brackets and commas. placing () outside the statement converts it to an array

spaceToFocus=$currentlyFocusedDisplaySpaces[$inputSpaceNumber]
currentSpace=$(yabai -m query --spaces --space | jq -re '.index')

windowOnThatSpace=$(yabai -m query --spaces --space $spaceToFocus | jq '."first-window"');

focusWindow() {
	sleep .1 # animation because of SIP
	$(yabai -m window --focus $1)
}

switchSpace() {
	# switch to that space using mission control shortcuts
	if [[ "$spaceToFocus" -ge "10" ]]; then
		key=$(($spaceToFocus-10))
		$(skhd -k "ctrl + alt - $key")
	else
		$(skhd -k "ctrl - $spaceToFocus")
	fi
	echo $windowOnThatSpace
	# highlight the first window on that space if any
	if [[ "$windowOnThatSpace" -ne "0" ]]; then
		focusWindow $windowOnThatSpace
	else
		# keep the focus on current display
		currentDisplay=$(yabai -m query --displays --display | jq -re '.index')
		$(yabai -m display --focus $currentDisplay)
	fi
}


# Already at the correct space, don't switch
if [[ "$spaceToFocus" -eq "$currentSpace" ]]; then
	exit 0
fi

switchSpace
