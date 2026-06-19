#!/usr/bin/env bash
# =============================================================================== #
# General:                                                                        #
# =============================================================================== #
# Environment: ===================================================================================
rm -rf ~/.config 2>/dev/null && mkdir -p ~/{.config,.local/share}
cd && mv way.dots ~/.local/

# .config: =======================================================================================
for config in $(ls $HOME/.local/way.dots/void-dotfiles/cfg); do
    ln -sf ~/.local/way.dots/void-dotfiles/cfg/$config ~/.config/
done

# .local/share: ==================================================================================
for theme in $(ls $HOME/.local/way.dots/void-dotfiles/others); do
    ln -sf ~/.local/way.dots/void-dotfiles/others/$theme ~/.local/share
done

for icon in $(ls $HOME/.local/way.dots/void-dotfiles/others/icons); do
    sudo ln -sf ~/.local/way.dots/void-dotfiles/others/icons/$icon /usr/share/icons/
done

# /home/user: ====================================================================================
ln -sf ~/.local/way.dots/void-dotfiles/home/.bash ~/
ln -sf ~/.local/way.dots/void-dotfiles/home/.bash/bashrc ~/.bashrc
ln -sf ~/.local/way.dots/void-dotfiles/home/.bash/bash_profile ~/.bash_profile
ln -sf ~/.local/way.dots/void-dotfiles/home/.others ~/
ln -sf ~/.local/way.dots/void-dotfiles/home/.others/npmrc ~/.npmrc
ln -sf ~/.local/way.dots/void-dotfiles/home/.others/gitconfig ~/.gitconfig
LC_ALL=C.UTF-8 xdg-user-dirs-update --force 2> /dev/null
mkdir -p ~/{Projects,Pictures,Desktop,Documents,Downloads,Music,Public,Videos}

# /etc: ==========================================================================================
sudo ln -sf ~/.local/way.dots/void-dotfiles/etc/rc/rc.local /etc/rc.local
sudo ln -sf ~/.local/way.dots/void-dotfiles/etc/grub/grub /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# =============================================================================== #
# Services:                                                                       #
# =============================================================================== #
# Enabled: =======================================================================================
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/elogind /var/service/
sudo ln -s /etc/sv/preload /var/service/
sudo ln -s /etc/sv/bluetoothd /var/service/
sudo ln -s /etc/sv/NetworkManager /var/service/
sudo ln -s /etc/sv/iwd /var/service/
# Disabled: =======================================================================================
sudo unlink /var/service/wpa_supplicant

# =============================================================================== #
# Audio:                                                                          #
# =============================================================================== #
# Wireplumper: ===================================================================================
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/

# Pulse: =========================================================================================
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# Alsa: ==========================================================================================
sudo mkdir -p /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

# =============================================================================== #
# Others:                                                                         #
# =============================================================================== #
# Iwd as networkmanager backend: =================================================================
sudo mkdir -p /etc/NetworkManager/conf.d
cat <<EOF | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf > /dev/null
[device]
wifi.backend=iwd
EOF

# Update the binary cache to use custom themes: ==================================================
bat cache --build

# Doas without password: =========================================================================
echo "permit nopass $(whoami) as root" | sudo tee /etc/doas.conf

# Fix font rendering: ============================================================================
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
sudo xbps-reconfigure -f fontconfig

# Reconfigure kernel: ============================================================================
sudo xbps-reconfigure -f linux$(uname -r | cut -d. -f1,2)
