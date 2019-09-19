#!/bin/bash
# requires i3-wm, jq, libnotify, udiskie

# check transmission
if [[ $(pgrep transmission) ]]; then
    notify-send -u critical "transmission is still running."
    exit 1
fi

i3-msg [class="."] kill

sleep 3

# check every window
apps=$(i3-msg -t get_tree | jq | grep -P "class" | awk '{print $2}' | tr -d ',"' | sed "/^null$/d" | sort)
n_apps=$(echo $apps | awk '{print NF}')
if [[ $n_apps -gt 0 ]]; then
    notify-send -u critical "$(echo -e "$n_apps running application(s).\n$apps")"
    exit 2
fi

kill $(pidof gnome-keyring-daemon)

udiskie-umount -ad

