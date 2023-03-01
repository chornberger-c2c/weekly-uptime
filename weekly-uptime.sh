#!/bin/bash
# show this week's machine uptime

# date
echo -n "$(last | awk '/reboot/ { print $5 " " $6 " " $7 " " $11 }' | head -1)"

# today's hours
TIME="$(uptime | awk '{ print $3 }' | sed "s/,//")"
if ! [[  "$TIME" =~ ":" ]]; then
  echo "(00:$TIME)"
else
  echo "(0$TIME)"
fi  

# this week, starting from Monday
last | awk '/reboot/ { print $5 " " $6 " " $7 " " $11 }' | tail -n +2 | head -5 | grep -B7 Mon
