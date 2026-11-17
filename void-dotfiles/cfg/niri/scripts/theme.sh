#!/usr/bin/env bash
# =============================================================================== #
# Theme:                                                                          #
# =============================================================================== #
# Preferences: ===================================================================================
THEME='Thorn-dark-sea'
ICONS='Kora'
CURSOR='BreezeX-Black'
FONT='JetBrainsMono Nerd Font 11'
COLOR='prefer-dark'
CURSORSIZE=25
SCHEMA='gsettings set org.gnome.desktop.interface'
PREFERENCES='gsettings set org.gnome.desktop.wm.preferences'

# Set Preferences: ===============================================================================
apply_themes() {
  ${PREFERENCES} theme "$THEME"
  ${SCHEMA} gtk-theme "$THEME"
  ${SCHEMA} icon-theme "$ICONS"
  ${SCHEMA} cursor-theme "$CURSOR"
  ${SCHEMA} cursor-size "$CURSORSIZE"
  ${SCHEMA} font-name "$FONT"
  ${SCHEMA} color-scheme "$COLOR"
}
apply_themes
