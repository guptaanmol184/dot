#!/usr/bin/env sh

exec 1>/tmp/autostart.log 2>&1

runCommand() {
    pkill "$(echo "$@" | cut -d ' ' -f 1)"
    ("$@" > /tmp/"$1.log" 2>&1) &
}

runCommand nm-applet
runCommand feh --bg-scale /home/ag/.config/qtile/wall
runCommand dunst
runCommand compton -c -b
runCommand redshift
runCommand rescuetime
runCommand unclutter --fork --exclude-root --ignore-scrolling
runCommand xautolock -time 3 -locker locker.sh
runCommand numlockx
