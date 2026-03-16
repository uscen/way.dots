#!/usr/bin/env bash
# =============================================================================== #
# Packages:                                                                       #
# =============================================================================== #
sudo xbps-install -Sy void-repo-nonfree && sudo xbps-install -S \
    mesa-intel-dri intel-video-accel intel-ucode base-devel elogind \
    alacritty foot elvish carapace \
    niri xwayland-satellite swayidle swaylock swww fuzzel fnott Waybar \
    xdg-user-dirs xdg-utils xdg-desktop-portal-gnome polkit-gnome psmisc man-db opendoas trash-cli htop aria2 ffmpeg ImageMagick ouch \
    yazi fastfetch yt-dlp chafa eza bat cliphist tealdeer \
    neovim lazygit fzf fd ripgrep zoxide pastel delta curl jq brightnessctl \
    obs mpv imv zathura zathura-pdf-mupdf firefox thunderbird nautilus gimp shotcut \
    udiskie gvfs gvfs-mtp gvfs-smb gvfs-afc gvfs-gphoto2 \
    NetworkManager network-manager-applet wireless-regdb impala \
    qt5-wayland qt6-wayland kvantum \
    pipewire wireplumber alsa-pipewire alsa-utils sof-firmware alsa-firmware pavucontrol \
    bluez bluez-alsa libspa-bluetooth bluetui blueman \
    nodejs yarn pnpm \
    noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-emoji noto-fonts-cjk font-awesome dejavu-fonts-ttf \
    gtk-engine-murrine papirus-icon-theme
