#!/usr/bin/env sh

[[ "$(hostname)" =~ 'Sigmachine' ]] \
    && xrandr --output HDMI-0 --right-of DP-1 --primary

. "$HOME/.profile"

notify-send "Welcome, $USER!" &
