#!/usr/bin/env bash
# =============================================================================== #
# Scratchpad:                                                                     #
# =============================================================================== #
RESIZE_HEIGHT="80%"
RESIZE_WIDTH="90%"
declare -A resize

# =============================================================================== #
# Arguements:                                                                     #
# =============================================================================== #
usage() {
    cat << EOF
usage: $(basename "$0") [-h] [-R] [-c] command|ACTIVE [windowclass] [title]
    -c: Use command string directly
    -R: Do not resize windows when unminimizing
    -h: Show help message
EOF
    exit "${1:-0}"
}

mode=desktop
do_resize=1
while getopts "hcR" opt; do
    case $opt in
        h) usage
            ;;
        c) mode=cmdline
            ;;
        R) do_resize=0
            ;;
        *) usage 1
            ;;
    esac
done
shift $((OPTIND -1))
[ -z "$1" ] && usage 1

cmd=$1
appid=${2:-$1}
title=$3


# =============================================================================== #
# app_id:                                                                         #
# =============================================================================== #
# Get window info by app_id and optional title: ==================================================
get_window_info() {
    local app=$1 titleval=$2
    local filter='.[] | select((.app_id | ascii_downcase)==($c | ascii_downcase))'
    [ -n "$titleval" ] && filter="$filter | select(.title==\$t)"

    niri msg -j windows | jq -r --arg c "$app" --arg t "$titleval" "$filter | \"\(.id)|\(.workspace_id)\"" | head -1
}


# =============================================================================== #
# Check:                                                                          #
# =============================================================================== #
# Check if window is on hidden workspace_id: =====================================================
is_hidden() {
    local ws_id=$1
    local ws_idx=$(niri msg -j workspaces | jq -r --arg id "$ws_id" '.[] | select(.id|tostring==$id) | .idx')
    local max_idx=$(niri msg -j workspaces | jq -r 'map(.idx) | max')
    [ "$ws_idx" -gt "$max_idx" ]
}

# Get hide workspace number: =====================================================================
get_hide_workspace() {
    niri msg -j workspaces | jq -r 'map(.idx) | max + 1'
}

# =============================================================================== #
# Resize:                                                                         #
# =============================================================================== #
# Resize and center window: ======================================================================
resize_window() {
    local win_id=$1 app=$2
    [ "$do_resize" -eq 0 ] && return

    local width height
    if [ -n "${resize[$app]}" ]; then
        IFS='|' read -r width height <<< "${resize[$app]}"
    else
        width=$RESIZE_WIDTH
        height=$RESIZE_HEIGHT
    fi

    niri msg action set-window-height --id "$win_id" "$height"
    niri msg action set-window-width --id "$win_id" "$width"
    sleep .1
    niri msg action center-window --id "$win_id"
}


# =============================================================================== #
# Show:                                                                           #
# =============================================================================== #
# Show window on current workspace: ==============================================================
show_window() {
    local win_id=$1 app=$2
    local cur_mon=$(niri msg -j focused-output | jq -r '.name')

    niri msg action move-window-to-floating --id "$win_id"
    niri msg action move-window-to-monitor --id "$win_id" "$cur_mon"
    niri msg action focus-window --id "$win_id"
    resize_window "$win_id" "$app"
}


# =============================================================================== #
# Hide:                                                                           #
# =============================================================================== #
# Hide window to last workspace + 1: =============================================================
hide_window() {
    local win_id=$1
    local hide_ws=$(get_hide_workspace)

    niri msg action move-window-to-workspace --focus false --window-id "$win_id" "$hide_ws"
    niri msg action move-window-to-tiling --id "$win_id"
    niri msg action set-window-width --id "$win_id" 100%
}


# =============================================================================== #
# Visibility:                                                                     #
# =============================================================================== #
# Toggle window visibility: ======================================================================
toggle_window() {
    local info=$(get_window_info "$1" "$2")
    [ -z "$info" ] && return 1

    local win_id="${info%|*}"
    local ws_id="${info#*|}"
    local cur_ws=$(niri msg -j focused-window | jq -r '.workspace_id')

    if is_hidden "$ws_id" || [ "$ws_id" != "$cur_ws" ]; then
        show_window "$win_id" "$1"
    else
        hide_window "$win_id"
    fi
}


# =============================================================================== #
# Launcher:                                                                       #
# =============================================================================== #
# Launch app and wait for window: ================================================================
launch_app() {
    local launch_cmd=$1
    local search_appid=$2
    local search_title=$3

    if [ "$mode" = "desktop" ]; then
        niri msg action spawn -- gtk-launch "$launch_cmd"
    else
        niri msg action spawn-sh -- "$launch_cmd"
    fi

    # Wait for window to appear: =================================================================
    local info count=0
    while [ $count -le 100 ]; do
        info=$(get_window_info "$search_appid" "$search_title")
        [ -n "$info" ] && break
        ((count++))
        sleep .1
    done

    if [ $count -ge 100 ]; then
        echo "Warning: No window found for $search_appid" >&2
        return 1
    fi

    show_window "${info%|*}" "$search_appid"
}

# =============================================================================== #
# Active:                                                                         #
# =============================================================================== #
# Handle ACTIVE window: ==========================================================================
toggle_active() {
    local focused=$(niri msg -j focused-window)
    local is_floating=$(jq -r .is_floating <<< "$focused")

    if [ "$is_floating" = "false" ]; then
        echo "Warning: Active window is not floating - not minimizing" >&2
        return 0
    fi

    local win_id=$(jq -r '.id' <<< "$focused")
    local ws_id=$(jq -r '.workspace_id' <<< "$focused")
    local app=$(jq -r '.app_id | ascii_downcase' <<< "$focused")

    if is_hidden "$ws_id"; then
        show_window "$win_id" "$app"
    else
        hide_window "$win_id"
    fi
}

# =============================================================================== #
# Main:                                                                           #
# =============================================================================== #
if [ "$cmd" = "ACTIVE" ]; then
    toggle_active
else
    get_window_info "$appid" "$title" >/dev/null && toggle_window "$appid" "$title" || launch_app "$cmd" "$appid" "$title"
fi
