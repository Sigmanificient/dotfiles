#!/usr/bin/env sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

. "$HOME/.profile"

notify-send "Welcome, $USER!" &
