#!/usr/bin/env bash

killall -q polybar

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar monitor-DVI >>/tmp/polybar1.log 2>&1 & disown
polybar monitor-HDMI >>/tmp/polybar2.log 2>&1 & disown
