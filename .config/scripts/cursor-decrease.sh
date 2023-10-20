#!/bin/bash

# Get the current cursor size
current_size=$(xset q | grep "Cursor" | awk '{print $3}')

# Decrease the cursor size by 4
new_size=$((current_size - 4))

# Set the new cursor size
xsetroot -cursor_name left_ptr -cursor_size $new_size

