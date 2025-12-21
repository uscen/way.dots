#!/bin/sh
echo "Environment: ==============================================================================="
rm -rf ~/.config 2>/dev/null && mkdir -p ~/{.config,.local/share}
cd && mv way.dots ~/.local/

echo "In ~/.config: =============================================================================="
for config in $(ls $HOME/.local/way.dots/void-dotfiles/cfg); do
    ln -sf ~/.local/way.dots/void-dotfiles/cfg/$config ~/.config/
done

echo "In ~/.local/share: ========================================================================="
ln -sf ~/.local/way.dots/void-dotfiles/fonts ~/.local/share/
ln -sf ~/.local/way.dots/void-dotfiles/themes ~/.local/share/
ln -sf ~/.local/way.dots/void-dotfiles/icons ~/.local/share/

echo "In ~/: ====================================================================================="
ln -sf ~/.local/way.dots/void-dotfiles/home/.bash ~/
ln -sf ~/.local/way.dots/void-dotfiles/home/.bash/bashrc ~/.bashrc
ln -sf ~/.local/way.dots/void-dotfiles/home/.bash/bash_profile ~/.bash_profile
ln -sf ~/.local/way.dots/void-dotfiles/home/.others ~/
ln -sf ~/.local/way.dots/void-dotfiles/home/.others/npmrc ~/.npmrc
ln -sf ~/.local/way.dots/void-dotfiles/home/.others/gitconfig ~/.gitconfig

echo "In /etc: ==================================================================================="
sudo ln -sf ~/.local/way.dots/void-dotfiles/etc/grub/grub /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "Home: ======================================================================================"
LC_ALL=C.UTF-8 xdg-user-dirs-update --force 2> /dev/null
mkdir -p ~/{Projects,Pictures,Desktop,Documents,Downloads,Music,Public,Videos}
ln -sf ~/.local/way.dots/void-dotfiles/pix ~/Pictures/

echo "Services: =================================================================================="
sudo ln -s /etc/sv/elogind /var/service/
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/NetworkManager /var/service/
sudo ln -s /etc/sv/bluetoothd /var/service/

echo "Wireplumper: ==============================================================================="
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/

echo "Pulse: ====================================================================================="
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

echo "Alsa: ======================================================================================"
sudo mkdir -p /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

echo "Doas: ======================================================================================"
sudo bash -c "echo 'permit nopass lli as root' > /etc/doas.conf"
