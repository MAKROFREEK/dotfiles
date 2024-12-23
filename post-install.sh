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



# Set Fish shell as default
echo "Setting Fish shell as the default shell..."
chsh -s $(which fish)

# Final system update
echo "Updating and cleaning up..."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

echo "All packages have been installed successfully! Restart your terminal or log out and log back in to use Fish shell."

# Neovim Vim Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Will still need to run :PlugInstall in neovim
