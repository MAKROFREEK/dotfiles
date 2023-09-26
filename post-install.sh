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
# install packages
bash post-install-scripts/install-timer.sh
bash post-install-scripts/get-packages.sh

# install yay
pacman -Syu
mkdir /tmp/yay
cd /tmp/yay
curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
makepkg -si
cd
rm -rf /tmp/yay
yay --version

# install plymouth and apply configurations
yay -S plymouth 
yay -S plymouth-theme-arch-charge-gdm-spinner
plymouth-set-default-theme -l
plymouth-set-default-theme -R arch-charge-gdm

