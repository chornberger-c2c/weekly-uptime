#!/bin/bash

# Initialize variables to hold total uptime
total_hours=0
total_minutes=0

# Get the current day of the week (1 for Monday, 7 for Sunday)
current_day=$(date +%u)

# Calculate uptime for the current day
current_uptime=$(uptime -s)
current_uptime_seconds=$(($(date +%s) - $(date -d "$current_uptime" +%s)))
current_uptime_hours=$((current_uptime_seconds / 3600))
current_uptime_minutes=$(((current_uptime_seconds % 3600) / 60))

# Add current day's uptime to the total
total_hours=$((total_hours + current_uptime_hours))
total_minutes=$((total_minutes + current_uptime_minutes))

# Loop through each day of the week starting from Monday (day 1)
for day in {1..7}; do
    # Calculate the day of the week to query in the last command
    target_day=$((current_day - day))
    
    # Adjust for days before Monday
    if [ "$target_day" -lt 1 ]; then
        target_day=$((target_day + 7))
    fi
    
    # Calculate uptime for the current day using the last command
    uptime_output=$(last -xF | grep "^reboot.*$target_day" | head -n 1)
    uptime_hours=$(echo "$uptime_output" | awk '{print $10}' | cut -d':' -f1)
    uptime_minutes=$(echo "$uptime_output" | awk '{print $10}' | cut -d':' -f2)
    
    # Add uptime to the total
    total_hours=$((total_hours + uptime_hours))
    total_minutes=$((total_minutes + uptime_minutes))
    
    # Print the uptime for the current day
    printf "Day %d Uptime: %02d:%02d\n" "$day" "$uptime_hours" "$uptime_minutes"
done

# Calculate extra hours from excess minutes
extra_hours=$((total_minutes / 60))
total_hours=$((total_hours + extra_hours))
total_minutes=$((total_minutes % 60))

# Print the total uptime for the week so far
printf "Total Week Uptime: %02d:%02d\n" "$total_hours" "$total_minutes"

