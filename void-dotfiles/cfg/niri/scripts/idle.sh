#!/usr/bin/env bash
# =============================================================================== #
# Idle:                                                                           #
# =============================================================================== #
LOCKFILE="$HOME/.config/niri/scripts/.swayidle_toggle.lock"
if pgrep -f "swayidle"; then
    pkill -f "swayidle"
    rm -f "$LOCKFILE"
    notify-send "Auto Suspend" "Auto Suspend is now disabled"
else
    swayidle -w \
      timeout 600 'niri msg action power-off-monitors' \
      timeout 630 'gtklock --daemonize' \
      timeout 900 'doas zzz' \
      resume 'niri msg action power-off-monitors' \
      before-sleep 'gtklock --daemonize' &
    touch "$LOCKFILE"
    notify-send "Auto Suspend" "Auto Suspend is now enabled"
fi
