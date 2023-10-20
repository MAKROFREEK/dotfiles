#!/bin/bash

# Send a notification displaying that the battery is charging or discharging
# Pass 1 as an argument for charging, 0 for discharging
# Example usage: chargingnotify 1

# Check if argument is passed
if [ $# != 1 ]; then
    echo "Usage: $0 0|1"
    exit 1
fi

# Set environment variables
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# Get battery status
BATTERY_CHARGING=$1
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

# Send notifications
if [ "$BATTERY_CHARGING" -eq 1 ]; then
    notify-send "Charging" "${BATTERY_LEVEL}% of battery charged." -u low -i "battery-charging" -t 5000 -r 9991
    # Play "device-added.oga" sound when plugging in

    pw-play /usr/share/sounds/freedesktop/stereo/device-added.oga
elif [ "$BATTERY_CHARGING" -eq 0 ]; then
    notify-send "Discharging" "${BATTERY_LEVEL}% of battery remaining." -u low -i "battery" -t 5000 -r 9991
    # Play "device-removed.oga" sound when unplugging
    pw-play /usr/share/sounds/freedesktop/stereo/device-removed.oga
fi

exit 0

