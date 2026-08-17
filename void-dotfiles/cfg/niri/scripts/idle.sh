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
    # Don't send notification in Login: ==========================================================
    FIRST_RUN=false
    if [ ! -f "$LOCKFILE" ]; then
        FIRST_RUN=true
    fi

    # Start swayidle: ============================================================================
    swayidle -w \
      timeout 600 'niri msg action power-off-monitors' \
      timeout 630 'gtklock --daemonize' \
      timeout 900 'doas zzz' \
      resume 'niri msg action power-on-monitors' \
      before-sleep 'gtklock --daemonize' &
    touch "$LOCKFILE"

    # Send notification but not when login: ======================================================
    [ "$FIRST_RUN" = true ] && notify-send "Auto Suspend" "Auto Suspend is now enabled"
fi
