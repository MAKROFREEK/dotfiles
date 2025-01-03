#!/bin/bash
# set -e  # Exit on any error

## FILES & DIRECTORIES

# Copy folders
cp -r .config/ ~/.config
cp -r .local/ ~/.local

# Copy themes
cp -r .themes/ ~/.themes

# Download and copy backgrounds
./get-backgrounds.sh

# Get curl wget git
sudo apt-get install git curl wget

## NEOVIM 
# Neovim - VimPlug installation and update prompt
read -p "Do you want to install VimPlug for Neovim and ensure the latest version is installed? (y/n): " neovim_setup
if [[ "$neovim_setup" =~ ^[Yy](es)?$ ]]; then
    # Neovim - Install VimPlug
    echo "Installing VimPlug for Neovim..."
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    # Neovim - Ensure latest version
    echo "Adding the latest Neovim repository..."
    sudo add-apt-repository ppa:neovim-ppa/stable
else
    echo "Skipping VimPlug installation and Neovim update."
fi

## PACKAGES
# Package installation prompt
read -p "Do you want to install the packages listed in 'packages-list'? (y/n): " packages_install
if [[ "$packages_install" =~ ^[Yy](es)?$ ]]; then
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
else
    echo "Skipping package installation."
fi


## FONTS
# Nerd Fonts installation prompt
read -p "Do you want to install Nerd Fonts? (y/n): " nerd_fonts
if [[ "$nerd_fonts" =~ ^[Yy](es)?$ ]]; then
    echo "Setting up Nerd Fonts..."
    ./nerd-fonts.sh
else
    echo "Skipping Nerd Fonts installation."
fi


# Hack pack
read -p "Do you want to install hackpack? (y/n): " user_input
if [[ "$user_input" =~ ^[Yy](es)?$ ]]; then
    # Run the script if the user chooses yes
    echo "Running the hackpack installation..."
    ./.config/hack-pack/dl_packages.sh
else
    # Continue if the user chooses no
    echo "Skipping the hackpack installation."
fi


## i3wm
# i3wm installation and auto-tiling setup prompt
read -p "Do you want to install i3wm and set up auto-tiling? (y/n): " i3wm_setup
if [[ "$i3wm_setup" =~ ^[Yy](es)?$ ]]; then
    echo "Installing i3wm and configuring auto-tiling..."
    pip3 install i3ipc
    # Ensure latest version of i3wm
    /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
    sudo apt install ./keyring.deb

    curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
    echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
    sudo apt update
    sudo apt install i3 dunst polybar ranger rofi 
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E3CA1A89941C42E6
else
    echo "Skipping i3wm installation."
fi


# Final system update
echo "Updating and cleaning up..."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

echo "Post install complete."

