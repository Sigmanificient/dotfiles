#!/usr/bin/env sh

[[ "$(hostname)" =~ 'Sigmachine' ]] \
    && xrandr --output HDMI-0 --right-of DP-1 --primary

notify-send "Welcome, $USER!" &
