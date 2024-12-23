#!/bin/bash
# set -e  # Exit on any error

# Copy folders
cp -r dotfiles/.config/* ~/.config
cp -r dotfiles/.local/* ~/.local

# Copy themes
mkdir -p ~/.themes
cp -r dotfiles/.themes/* ~/.themes

# Neovim 
# VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Ensure latest version
sudo add-apt-repository ppa:neovim-ppa/stable

# Check if the packages-list file exists
if [ ! -f "packages-list" ]; then
    echo "Error: packages-list file not found!"
    exit 1
fi

# Read the packages from the file and install them
echo "Installing packages from packages-list..."
while IFS= read -r package; do
    # Ignore empty lines and comments (lines starting with #)
    if [[ -n "$package" && ! "$package" =~ ^# ]]; then
        echo "Installing $package..."
        sudo apt install -y "$package"
    fi
done < "packages-list"

# Install packages
# echo "Installing packages..."
# sudo apt install -y software-properties-common curl wget gnupg kitty neovim neofetch git btop dunst ranger zathura zathura-pdf-poppler rofi vlc steam spotify-client gnome-tweaks



# Final system update
echo "Updating and cleaning up..."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

echo "All packages have been installed successfully!"

# Download and copy backgrounds
bash dotfiles/get-backgrounds.sh

