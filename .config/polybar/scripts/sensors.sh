#!/bin/bash

# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')

# Get CPU temperature (assuming you have lm-sensors installed)
cpu_temp=$(sensors | grep "Core 0" | awk '{print $3}')

# Get GPU usage (you might need to install and configure a GPU monitoring tool like nvidia-smi or radeontop)
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# Get GPU temperature (you might need to install and configure a GPU monitoring tool)
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

# Get memory usage
memory_info=($(free -h | grep Mem))
mem_total=${memory_info[1]}
mem_used=${memory_info[2]}

# Get network upload and download speeds (replace 'eth0' with your network interface)
# net_info=($(ifstat -i eth0 -b -q 1 1 | tail -n 1))
# net_up=${net_info[0]}
# net_down=${net_info[2]}

# Print the output in the desired format
echo "CPU: $cpu_usage% ($cpu_temp°C) | GPU: $gpu_usage% ($gpu_temp°C) | Mem: $mem_used / $mem_total "

