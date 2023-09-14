#!/bin/bash

# Initialize variables to hold total uptime
total_hours=0
total_minutes=0

# Define an array of abbreviated day names, starting with Mon
declare -a days=("Mon" "Tue" "Wed" "Thu" "Fri")

# Get the current day of the week (1 for Monday, 7 for Sunday)
current_day=$(date +%a)

# Loop through each day of the week starting from last Monday (day 1)
for day in "${days[@]}"; do

	# Calculate uptime for the current day using the last command
	if [[ "$day" =~ "$current_day" ]]; then
		uptime_output=$(uptime | awk '{print $3}')
	else
		uptime_output=$(last -xF | grep -m1 "^reboot.*$day" | awk '{gsub("[()]", "", $16); print $16}')
	fi

	if [[ "$uptime_output" =~ ([0-9]+):([0-9]+) ]]; then
		uptime_hours="${BASH_REMATCH[1]}"
		uptime_minutes="${BASH_REMATCH[2]}"
	fi
	# Remove leading zeros from hours and minutes for calculations
	uptime_hours=$(echo "$uptime_hours" | sed 's/^0//')
	uptime_minutes=$(echo "$uptime_minutes" | sed 's/^0//')
	today_uptime_hours=$(echo "$today_uptime_hours" | sed 's/^0//')
	today_uptime_minutes=$(echo "$today_uptime_minutes" | sed 's/^0//')

	# Print the uptime for the current day
	printf "%s Uptime: %02d:%02d\n" "$day" "$uptime_hours" "$uptime_minutes"
	# Calculate total uptime for the week (excluding future and today)
	total_hours=$((total_hours + uptime_hours + today_uptime_hours))
	total_minutes=$((total_minutes + uptime_minutes + today_uptime_minutes))

	if [[ "$day" =~ "$current_day" ]]; then
		break
	fi
done

# Calculate extra hours from excess minutes
extra_hours=$((total_minutes / 60))
total_hours=$((total_hours + extra_hours))
total_minutes=$((total_minutes % 60))

# Print the total uptime for the week so far
printf "\nTotal Week Uptime: %02d:%02d\n" "$total_hours" "$total_minutes"
