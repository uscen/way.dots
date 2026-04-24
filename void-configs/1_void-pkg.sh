#!/usr/bin/env bash
# =============================================================================== #
# Packages:                                                                       #
# =============================================================================== #
sudo xbps-install -Sy void-repo-nonfree && sudo xbps-install -S \
    mesa-intel-dri intel-video-accel intel-ucode base-devel xtools elogind fwupd preload \
    alacritty foot elvish carapace \
    niri xwayland-satellite gtklock awww fuzzel fnott Waybar \
    xdg-user-dirs xdg-utils xdg-desktop-portal-gnome polkit-gnome psmisc man-db opendoas trash-cli htop aria2 ffmpeg ImageMagick ouch \
    yazi fastfetch yt-dlp chafa eza bat cliphist tealdeer \
    neovim lua-language-server lazygit fzf fd ripgrep zoxide pastel delta curl jq brightnessctl \
    neovide obs mpv imv zathura zathura-pdf-mupdf firefox thunderbird nautilus gimp shotcut \
    udiskie gvfs gvfs-mtp gvfs-smb gvfs-afc gvfs-gphoto2 \
    NetworkManager network-manager-applet wireless-regdb impala \
    qt5-wayland qt6-wayland kvantum \
    pipewire wireplumber alsa-pipewire alsa-utils sof-firmware alsa-firmware pavucontrol \
    bluez bluez-alsa libspa-bluetooth bluetui blueman \
    nodejs yarn pnpm \
    noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-emoji noto-fonts-cjk font-awesome dejavu-fonts-ttf \
    gtk-engine-murrine papirus-icon-theme

# =============================================================================== #
# Reboot:                                                                         #
# =============================================================================== #
if [ $? -eq 0 ]; then
    echo -e "\n\033[0;32m[+] Installation successful!\033[0m"
    echo "Synchronizing data and rebooting in 5 seconds... (Press Ctrl+C to cancel)"
    sync
    sleep 5
    sudo reboot
else
    echo -e "\n\033[0;31m[!] Installation failed. Please check the errors above.\033[0m"
    exit 1
fi
