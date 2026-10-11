#!/usr/bin/env bash
# =============================================================================== #
# Idle:                                                                           #
# =============================================================================== #
LOCKFILE="$HOME/.config/niri/scripts/.swayidle_toggle.lock"
notify() { [[ "$1" == "--no-quiet" ]] && notify-send "Auto Suspend" "$2"; }

if pgrep -f "swayidle"; then
    # kill swayidle: ============================================================================
    pkill -f "swayidle"
    rm -f "$LOCKFILE"

    # Send notification: =========================================================================
    notify "$1" "Auto Suspend is now disabled"
else
    # Start swayidle: ============================================================================
    swayidle -w \
      timeout 900 'gtklock --daemonize' \
      timeout 999 'doas zzz' \
      before-sleep 'gtklock --daemonize' &
    touch "$LOCKFILE"

    # Send notification: =========================================================================
    notify "$1" "Auto Suspend is now enabled"
fi
