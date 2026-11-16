#!/usr/bin/env bash
# =============================================================================== #
# Theme:                                                                          #
# =============================================================================== #
THEME='Thorn-dark-sea'
ICONS='Kora'
CURSOR='BreezeX-Black'
FONT='JetBrainsMono Nerd Font 11'
COLOR='prefer-dark'
CURSORSIZE=25
SCHEMA='gsettings set org.gnome.desktop.interface'
PREFERENCES='gsettings set org.gnome.desktop.wm.preferences'
CONOTIFY='gsettings set org.gnome.nm-applet'
DISNOTIFY='gsettings set org.gnome.nm-applet'

apply_themes() {
  ${SCHEMA} gtk-theme "$THEME"
  ${SCHEMA} icon-theme "$ICONS"
  ${SCHEMA} cursor-theme "$CURSOR"
  ${SCHEMA} cursor-size "$CURSORSIZE"
  ${SCHEMA} font-name "$FONT"
  ${SCHEMA} color-scheme "$COLOR"
  ${PREFERENCES} theme "$THEME"
  ${CONOTIFY} disable-connected-notifications "true"
  ${DISNOTIFY} disable-disconnected-notifications "true"
}

apply_themes
