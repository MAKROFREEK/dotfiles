#!/bin/bash
set -e  # Exit on any error

# Copy folders
cp -r dotfiles/.config/* ~/.config
cp -r dotfiles/.local/* ~/.local

# Copy themes
mkdir -p ~/.themes
cp -r dotfiles/.themes/* ~/.themes

# Update and upgrade the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install packages
echo "Installing packages..."
sudo apt install -y software-properties-common curl wget gnupg kitty neovim neofetch git btop dunst ranger zathura zathura-pdf-poppler rofi vlc steam spotify-client gnome-tweaks

# Final system update
echo "Updating and cleaning up..."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

echo "All packages have been installed successfully!"

# Neovim Vim Plug
# Will still need to run :PlugInstall in neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Download and copy backgrounds
bash dotfiles/get-backgrounds.sh
