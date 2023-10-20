#!/bin/bash

XDG_RUNTIME_DIR=/run/user/1000

# Specify the path to your sound file
sound_file="/usr/share/sounds/freedesktop/stereo/window-attention.oga"


current_time=$(date +"%I:%M %p")

# Check if the sound file exists
if [ -f "$sound_file" ]; then
    # Play the sound
    notify-send "It is currently ""$current_time"
    paplay "$sound_file"
    paplay "$sound_file"
else
    echo "Sound file not found: $sound_file"
fi

