#!/bin/bash

# Initialize variables to hold total uptime
total_hours=0
total_minutes=0

# Define an array of abbreviated day names, starting with Mon
days=("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun")

# Get the current day of the week (1 for Monday, 7 for Sunday)
current_day=$(date +%u)

# Loop through each day of the week starting from Monday (day 1)
for day in {0..6}; do
    # Calculate the index for the day name in the array
    day_index=$(( (current_day + day - 1) % 7 ))
    target_day_name=${days[$day_index]}
    
    # Calculate uptime for the current day using the last command
    if [ "$day" -eq 0 ]; then
        uptime_output=$(uptime -p)
    else
        uptime_output=$(last -xF | grep "^reboot.*$target_day_name" | head -n 1)
    fi
    
    uptime_hours=$(echo "$uptime_output" | awk '{gsub("[()]", "", $2); print $2}' | sed 's/h//')
    uptime_minutes=$(echo "$uptime_output" | awk '{gsub("[()]", "", $3); print $3}' | sed 's/m//')
    
    # Add uptime to the total
    total_hours=$((total_hours + uptime_hours))
    total_minutes=$((total_minutes + uptime_minutes))
    
    # Print the uptime for the current day
    printf "Day %s Uptime: %02d:%02d\n" "$target_day_name" "$uptime_hours" "$uptime_minutes"
done

# Calculate extra hours from excess minutes
extra_hours=$((total_minutes / 60))
total_hours=$((total_hours + extra_hours))
total_minutes=$((total_minutes % 60))

# Print the total uptime for the week so far
printf "Total Week Uptime: %02d:%02d\n" "$total_hours" "$total_minutes"
