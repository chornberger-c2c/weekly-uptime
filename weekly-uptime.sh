#!/bin/bash
# show this week's machine uptime

date() {
  echo -n "$(last | awk '/reboot/ { print $5 " " $6 " " $7 " " $11 }' | head -1)"
}

hours() {
  TIME="$(uptime | awk '{ print $3 }' | sed "s/,//")"
  if ! [[  "$TIME" =~ ":" ]]; then
    echo "(00:$TIME)"
  else
    echo "(0$TIME)"
  fi
}

week() {
  last | awk '/reboot/ { print $5 " " $6 " " $7 " " $11 }' | tail -n +2 | grep -B16 -m1 Mon
}

main() {
  date
  hours
  week
}

main "$@" || exit 1
