#!/bin/bash
set -e  # Exit on any error

# Copy folders
cp -r dotfiles/.config/* ~/.config
cp -r dotfiles/.local/* ~/.local
cp -r dotfiles/documents/* ~/Documents

# Copy themes
mkdir -p ~/.themes
cp -r dotfiles/.themes/* ~/.themes

# Update and upgrade the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install packages
echo "Installing packages..."
sudo apt install -y software-properties-common curl wget gnupg kitty neovim neofetch git ocs-url btop dunst ranger zathura zathura-pdf-poppler rofi vlc steam spotify-client fish ttf-ubuntu-mono-nerd papirus-folders-git gnome-tweaks

# Third-party applications
# Discord
if curl -L -o discord.deb "https://discord.com/api/download?platform=linux&format=deb"; then
    sudo apt install -y ./discord.deb
    rm discord.deb
else
    echo "Failed to download Discord. Skipping..."
fi

# Obsidian
if curl -L -o obsidian.deb "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.1.16/Obsidian-1.1.16.deb"; then
    sudo apt install -y ./obsidian.deb
    rm obsidian.deb
else
    echo "Failed to download Obsidian. Skipping..."
fi

# Angry IP Scanner
if wget -q "https://github.com/angryip/ipscan/releases/download/3.9.0/ipscan_3.9.0_amd64.deb"; then
    sudo apt install -y ./ipscan_3.9.0_amd64.deb
    rm ipscan_3.9.0_amd64.deb
else
    echo "Failed to download Angry IP Scanner. Skipping..."
fi

# Prism Launcher
if wget -q "https://github.com/PrismLauncher/PrismLauncher/releases/download/v7.1/PrismLauncher-7.1-linux64.deb"; then
    sudo apt install -y ./PrismLauncher-7.1-linux64.deb
    rm PrismLauncher-7.1-linux64.deb
else
    echo "Failed to download Prism Launcher. Skipping..."
fi

# Set Fish shell as default
echo "Setting Fish shell as the default shell..."
chsh -s $(which fish)

# Final system update
echo "Updating and cleaning up..."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

echo "All packages have been installed successfully! Restart your terminal or log out and log back in to use Fish shell."


# install yay
# mkdir /tmp/yay
# cd /tmp/yay
# curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
# makepkg -si
# cd
# rm -rf /tmp/yay
# yay --version

# copy grub
# git clone https://github.com/Patato777/dotfiles.git ~/virtuaverse-grub
# cd ~/virtuaverse-grub
# cd grub
# bash install_script_grub.sh
# cd rm -r ~/virtuaverse-grub
# # copy sddm
# yay -S 
# # copy plymouth
# yay -S 
# # install packages
# bash post-install-scripts/install-timer.sh
# bash post-install-scripts/get-packages.sh

# # install plymouth and apply configurations
# yay -S plymouth 
# yay -S plymouth-theme-arch-charge-gdm-spinner
# plymouth-set-default-theme -l
# plymouth-set-default-theme -R arch-charge-gdm

