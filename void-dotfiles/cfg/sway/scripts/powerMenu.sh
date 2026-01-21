#!/bin/bash
# =============================================================================== #
# Power Menu:                                                                     #
# =============================================================================== #
options=$(printf "POWER OFF\nREBOOT\nSUSPEND\nHIBERNATE\nLOCK\nLOG OUT")

selected=$(echo -e "$options" | wmenu_run)

case "$selected" in
	"POWER OFF") doas poweroff ;;
	"REBOOT") doas reboot ;;
	"SUSPEND") doas zzz ;;
	"HIBERNATE") doas zzz ;;
	"LOCK") swaylock ;;
	"LOG OUT") swaymsg exit ;;
	*) exit 1 ;;
esac
