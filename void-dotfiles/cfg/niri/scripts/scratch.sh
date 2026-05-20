#! /usr/bin/env bash
# =============================================================================== #
# Scratchpad:                                                                     #
# =============================================================================== #
# Check if an argument is provided: ==============================================================
if [ -z "$1" ]; then
  echo "Error: No argument provided."
  exit 1
fi

# Commands to run the programs: ==================================================================
TERMINAL="foot"
term="$TERMINAL --app-id special-term"
btop="$TERMINAL --app-id special-btop -e bash -c btop"
files="$TERMINAL --app-id special-files -e bash -c yazi"

# The case statements need the app-id of the program: ============================================
case "$1" in
"special-term")
  cmd="$term"
  ;;
"special-btop")
  cmd="$btop"
  ;;
"special-files")
  cmd="$files"
  ;;
*)
  echo "Unhandled case provided. Exiting"
  exit 1
  ;;
esac

# Get window info from niri msg windows output: ==================================================
WIN_INFO=$(niri msg -j windows | jq --arg search "$1" '.[] | select (.app_id | test($search)) | { id, is_focused }')
ID=$(echo "$WIN_INFO" | jq -r '.id // empty')
IS_FOCUSED=$(echo "$WIN_INFO" | jq -r '.is_focused // empty')

# Spawn window if it's not open, or focus the window if it's already open: =======================
if [ -z "$ID" ]; then
  niri msg action spawn -- "sh" "-c" "$cmd"
elif [ "$IS_FOCUSED" = "true" ]; then
  niri msg action focus-window-previous
else
  niri msg action focus-window --id "$ID"
fi
