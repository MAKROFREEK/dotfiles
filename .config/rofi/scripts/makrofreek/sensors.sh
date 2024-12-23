#!/bin/bash

# Function to get CPU temperature
get_cpu_temp() {
  if command -v sensors &> /dev/null; then
    sensors | grep "Core 0" | awk '{print $3}' | cut -c 2- | sed 's/+//'
  elif command -v cat /sys/class/thermal/thermal_zone0/temp &> /dev/null; then
    echo "$(cat /sys/class/thermal/thermal_zone0/temp /sys/class/thermal/thermal_zone1/temp | awk '{sum += $1} END {print sum/NR / 1000}')°C"
  else
    echo "N/A"
  fi
}

# Function to get CPU usage percentage
get_cpu_usage() {
  top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | awk -F. '{print $1"%"}'
}

# Function to get disk usage percentage
get_disk_usage() {
  df -h / | awk 'NR==2 {print $5}'
}

# Function to get other useful system stats
get_system_stats() {
  uptime -p | sed 's/up //'
}

# Output the information to be displayed in Waybar tooltip
echo " $(get_cpu_temp)"
echo " $(get_cpu_usage)"
echo " $(get_disk_usage)"
echo " $(get_system_stats)"

