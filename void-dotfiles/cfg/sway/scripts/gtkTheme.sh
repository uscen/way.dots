#!/bin/sh
# =============================================================================== #
# UI Settings:                                                                    #
# =============================================================================== #
THEME='Material-Black-Blueberry'
ICONS='Papirus-Dark'
FONT='JetBrainsMono NF 11'
CURSOR='BreezeX-Black'
CURSORSIZE=30
SCHEMA='gsettings set org.gnome.desktop.interface'
PERF='gsettings set org.gnome.desktop.wm.preferences'

apply_themes() {
  ${SCHEMA} gtk-theme "$THEME"
  ${SCHEMA} icon-theme "$ICONS"
  ${SCHEMA} cursor-theme "$CURSOR"
  ${SCHEMA} cursor-size "$CURSORSIZE"
  ${SCHEMA} font-name "$FONT"
  ${SCHEMA} color-scheme "prefer-dark"
  ${PERF} theme "$THEME"
}

apply_themes
