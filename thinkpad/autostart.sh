#!/usr/bin/env sh

# Set wallpaper
nitrogen --restore

pidof mpd || mpd
pidof megasync || megasync &
