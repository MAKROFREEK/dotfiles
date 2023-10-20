#!/bin/sh

# Import Current Theme
DIR="$HOME/.config/rofi"
STYLE="default"
RASI="$DIR/themes/$STYLE/rofi/timer.rasi"



# Get the duration input from the user using Rofi
duration_input=$(rofi -dmenu -p 'Duration:')

# Check if the input contains a unit (s for seconds, m for minutes, h for hours)
if echo "$duration_input" | grep -qE '^[0-9]+[sSmMhH]*$'; then
    # Extract the numeric part and the unit
    duration_value=$(echo "$duration_input" | sed 's/[^0-9]//g')
    duration_unit=$(echo "$duration_input" | sed 's/[0-9]//g')

    # Calculate the total seconds based on the unit and display a human-readable duration
    case "$duration_unit" in
        "s" | "")
            seconds="$duration_value"
            human_readable_unit="seconds"
            ;;
        "m")
            seconds="$((duration_value * 60))"
            human_readable_unit="minutes"
            ;;
        "h")
            seconds="$((duration_value * 3600))"
            human_readable_unit="hours"
            ;;
        *)
            notify-send "Invalid duration format. 
[s]econds [m]inutes [h]ours"
            exit 1
            ;;
    esac
else
    notify-send "Invalid duration format. 
[s]econds [m]inutes [h]ours."
    exit 1
fi

if [ "$seconds" -ge 1 ] ; then
    # Display a notification to indicate that the timer has started
    notify-send "⏳ Timer started for $duration_value $human_readable_unit"

    # Start the timer and display a notification when it expires
    sleep "$seconds" && notify-send "⏰ $duration_value $human_readable_unit have passed!" && paplay /usr/share/sounds/freedesktop/stereo/complete.oga
else
    echo "Invalid duration. Please enter a valid duration."
    exit 2
fi
