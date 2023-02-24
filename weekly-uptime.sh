#!/bin/bash
# show this week's machine uptime

echo -n $(last | awk '/reboot/ { print $5 " " $6 " " $7 " " $11 }' | head -1)
echo " (0$(uptime | awk '{ print $3 }'| sed "s/,//"))"
last | awk '/reboot/ { print $5 " " $6 " " $7 " " $11 }' | tail -n +2 | head -5
