#!/usr/bin/env bash
# =============================================================================== #
# Theme:                                                                          #
# =============================================================================== #
THEME='Kripton'
ICONS='Papirus-Dark'
FONT='JetBrainsMono Nerd Font 12'
CURSOR='BreezeX-Black'
CURSORSIZE=30
SCHEMA='gsettings set org.gnome.desktop.interface'
PERF='gsettings set org.gnome.desktop.wm.preferences'

apply_themes() {
  ${PERF} theme "$THEME"
  ${SCHEMA} gtk-theme "$THEME"
  ${SCHEMA} icon-theme "$ICONS"
  ${SCHEMA} cursor-theme "$CURSOR"
  ${SCHEMA} cursor-size "$CURSORSIZE"
  ${SCHEMA} font-name "$FONT"
  ${SCHEMA} color-scheme "prefer-dark"
}

apply_themes
