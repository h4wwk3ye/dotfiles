#!/bin/zsh

spacePosition=$1

focusWindow() {
	sleep .1 # animation because of SIP
	$(yabai -m window --focus $1)
}

windowOnSpace=

# get the array of current spaces 
currentlyFocusedDisplaySpaces=($(yabai -m query --displays --display | jq -re '.spaces' | tr -d '[],')) 
# tr removes square brackets and commas. placing () outside the statement converts it to an array
currentSpace=$(yabai -m query --spaces --space | jq -re '.index')


if [[ "$spacePosition" == "left" ]]; then
	# if it's the first space don't switch
	if [[ "$currentSpace" -eq currentlyFocusedDisplaySpaces[1] ]]; then
		exit 0
	fi

	windowOnSpace=$(yabai -m query --spaces --space prev | jq '."first-window"');

	#switch to space on left
	$(skhd -k "ctrl - left")
else
	# if it's the last space don't switch
	if [[ "$currentSpace" -eq currentlyFocusedDisplaySpaces[-1] ]]; then
		exit 0
	fi

	windowOnSpace=$(yabai -m query --spaces --space next | jq '."first-window"');

	#switch to space on right
	$(skhd -k "ctrl - right")
fi

echo $windowOnSpace

currentDisplay=$(yabai -m query --displays --display | jq -re '.index')
echo $currentDisplay

# highlight the first window on that space if any
# native full screen app also has 0 id 
nativeFullScreen=$(yabai -m query --spaces --space | jq -re '."native-fullscreen"')

if [[ "$windowOnSpace" -ne "0" && nativeFullScreen -ne "1" ]]; then
	focusWindow $windowOnSpace
else
	# keep the focus on current display
	currentDisplay=$(yabai -m query --displays --display | jq -re '.index')
	echo $currentDisplay
	sleep .1
	$(yabai -m display --focus $currentDisplay)
fi
