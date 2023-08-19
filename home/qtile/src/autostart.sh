#!/usr/bin/env sh

[[ "$(hostname)" =~ 'Sigmachine' ]] \
    && xrandr --output HDMI-0 --right-of DP-1 --primary

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

. "$HOME/.profile"

notify-send "Welcome, $USER!" &
