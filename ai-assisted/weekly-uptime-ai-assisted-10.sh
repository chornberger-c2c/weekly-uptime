#!/bin/bash

# Initialize variables to hold total uptime
total_hours=0
total_minutes=0

# Define an array of abbreviated day names, starting with Mon
days=("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun")

# Get the current day of the week (1 for Monday, 7 for Sunday)
current_day=$(date +%u)

# Calculate the day offset to start from Monday
offset=$((current_day - 1))

# Loop through each day of the week starting from Monday (day 1)
for day in {0..6}; do
    # Calculate the index for the day name in the array
    day_index=$(( (offset + day) % 7 ))
    target_day_name=${days[$day_index]}

    # Calculate uptime for the current day using the last command
    if [ "$day" -eq 0 ]; then
        uptime_output=$(uptime -p)
    else
        uptime_output=$(last -xF | grep "^reboot.*$target_day_name" | head -n 1)
    fi

    if [[ "$uptime_output" =~ up\ ([0-9]+)\ days,\ ([0-9]+):([0-9]+) || "$uptime_output" =~ up\ ([0-9]+)\ hours,\ ([0-9]+)\ minutes ]]; then
        if [[ "${BASH_REMATCH[1]}" ]]; then
            uptime_days="${BASH_REMATCH[1]}"
        else
            uptime_days="0"
        fi
        uptime_hours="${BASH_REMATCH[2]}"
        uptime_minutes="${BASH_REMATCH[3]}"
    else
        uptime_days="0"
        uptime_hours="0"
        uptime_minutes="0"
    fi

    # Add uptime to the total
    total_hours=$((total_hours + uptime_days * 24 + uptime_hours))
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

