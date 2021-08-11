#!/usr/bin/env sh

# Display settings
xrandr --output DVI-I-1 --mode 1920x1080 --rate 144.00
xrandr --output HDMI-0 --mode 1920x1080 --rate 60.00 --right-of DVI-I-1
displaycal-apply-profiles

# Set wallpaper
nitrogen --restore
picom --experimental-backends &

# Notification | Music | Mouse | Eyes | Cursor
dunst &
pidof mpd || mpd
imwheel --kill -b 45
pidof redshift || redshift -l 45:10 &> /dev/null &
pidof megasync || megasync &
