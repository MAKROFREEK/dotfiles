#!/bin/bash

# Define your time steps (in 24-hour format, e.g., 18:00 for 6:00 PM)
step1_time="10:00"
step2_time="12:00"
step3_time="14:00"
step4_time="16:00"
step5_time="18:00"

# Define corresponding redshift values for each time step
step5_temp="3500"
step4_temp="4000"
step3_temp="4500"
step2_temp="5000"
step1_temp="5500"

current_time=$(date +%H:%M)

if [[ "$current_time" < "$step1_time" ]]; then
    redshift -O $step1_temp
elif [[ "$current_time" < "$step2_time" ]]; then
    redshift -O $step2_temp
elif [[ "$current_time" < "$step3_time" ]]; then
    redshift -O $step3_temp
elif [[ "$current_time" < "$step4_time" ]]; then
    redshift -O $step4_temp
else
    redshift -O $step5_temp
fi

