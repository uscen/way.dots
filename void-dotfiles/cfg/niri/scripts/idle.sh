#!/usr/bin/env bash
# =============================================================================== #
# Idle:                                                                           #
# =============================================================================== #
swayidle -w \
	timeout 300 'swaylock' \
  timeout 600 'niri msg action power-off-monitors' resume 'niri msg action power-on-monitors' \
  before-sleep 'swaylock'
