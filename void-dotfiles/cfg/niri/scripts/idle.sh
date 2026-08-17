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
    FIRST_RUN=true
    if [ ! -f "$LOCKFILE" ]; then
        FIRST_RUN=false
    fi

    # Start swayidle: ============================================================================
    swayidle -w \
      timeout 600 'niri msg action power-off-monitors' \
      timeout 630 'gtklock --daemonize' \
      timeout 900 'doas zzz' \
      resume 'niri msg action power-off-monitors' \
      before-sleep 'gtklock --daemonize' &
    touch "$LOCKFILE"

    # Send notification but not when login: ======================================================
    if [ "$FIRST_RUN" = false ]; then
      notify-send "Auto Suspend" "Auto Suspend is now enabled"
    fi
fi
