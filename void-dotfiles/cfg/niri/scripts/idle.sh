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
      timeout 300 'niri msg action power-off-monitors' \
      timeout 330 'gtklock --daemonize' \
      timeout 600 'doas zzz' \
      resume 'niri msg action power-off-monitors' \
      before-sleep 'gtklock --daemonize' &
    touch "$LOCKFILE"
    notify-send "Auto Suspend" "Auto Suspend is now enabled"
fi
