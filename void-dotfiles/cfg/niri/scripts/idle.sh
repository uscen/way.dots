#!/usr/bin/env bash
# =============================================================================== #
# Idle:                                                                           #
# =============================================================================== #
LOCKFILE="$HOME/.config/niri/scripts/.swayidle_toggle.lock"
if pgrep -f "swayidle"; then
    # kill swayidle: ============================================================================
    pkill -f "swayidle"
    rm -f "$LOCKFILE"

    # Send notification: =========================================================================
    notify-send "Auto Suspend" "Auto Suspend is now disabled"
else
    # Start swayidle: ============================================================================
    swayidle -w \
      timeout 900 'niri msg action power-off-monitors' \
      timeout 930 'gtklock --daemonize' \
      timeout 999 'doas zzz' \
      resume 'niri msg action power-on-monitors' \
      before-sleep 'gtklock --daemonize' &
    touch "$LOCKFILE"

    # Send notification: =========================================================================
    notify-send "Auto Suspend" "Auto Suspend is now enabled"
fi
