

#!/bin/bash

# check if running as sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (sudo)." 
    exit 1
fi

# copy folders
cp -r .config ~/.config

# copy background
cp -r .local ~/.local

# copy documents
cp -r documents ~/Documents

# install yay
pacman -Syu
mkdir /tmp/yay
cd /tmp/yay
curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
makepkg -si
cd
rm -rf /tmp/yay
yay --version

# copy grub
git clone https://github.com/Patato777/dotfiles.git ~/virtuaverse-grub
cd ~/virtuaverse-grub
cd grub
bash install_script_grub.sh
cd rm -r ~/virtuaverse-grub
# copy sddm
yay -S 
# copy plymouth
yay -S 
# install packages
bash post-install-scripts/install-timer.sh
bash post-install-scripts/get-packages.sh

# install plymouth and apply configurations
yay -S plymouth 
yay -S plymouth-theme-arch-charge-gdm-spinner
plymouth-set-default-theme -l
plymouth-set-default-theme -R arch-charge-gdm
systemctl disable sddm.service
system enable sddm-plymouth.service

