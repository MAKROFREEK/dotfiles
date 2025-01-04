#!/bin/bash
# set -e  # Exit on any error

## FILES & DIRECTORIES
cp -r .config/ ~/.config
cp -r .local/ ~/.local
cp -r .themes/ ~/.themes

## BACKGROUNDS
./get-backgrounds.sh

## REQUIREEMENTS
sudo apt-get install git curl wget -y

## INIT UPDATE
sudo apt-get update

## APPLICATIONS

read -p "Do you want to install VimPlug for Neovim and ensure the latest version is installed? (y/n): " neovim_setup
if [[ "$neovim_setup" =~ ^[Yy](es)?$ ]]; then
    echo "Installing VimPlug for Neovim..."
    # Download VimPlug
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "Adding the latest Neovim repository and updating Neovim..."
    # Add Neovim repository and update
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    export PATH="$PATH:/opt/nvim-linux64/bin"

    echo "VimPlug installed and Neovim updated successfully!"
else
    echo "Skipping VimPlug installation and Neovim update."
fi


## PACKAGES
# Check if the packages-list file exists
if [[ ! -f packages-list ]]; then
    echo "Error: packages-list file not found."
    exit 1
fi

# Ask the user if they want to proceed
read -p "Do you want to install packages from packages-list? (yes/no): " response

# If "no", skip installation and continue
if [[ "$response" == "no" ]]; then
    echo "Skipping package installation."
else
    # Read the file line by line and install each package
    while IFS= read -r package; do
        if [[ -n "$package" && "$package" != \#* ]]; then
            echo "Installing $package..."
            sudo apt-get install -y "$package" || {
                echo "Failed to install $package. Skipping..."
            }
        fi
    done < packages-list
    echo "All packages processed."
fi

# Continue the script if more operations are to follow
echo "Script execution completed."


# Section for Spotify
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

## Desktop Gaming
read -p "Will you be gaming with this setup? (y/n): " user_input
if [[ "$user_input" =~ &[Yy(es)?$ ]]; then

    # Section for Steam
    wget -O steam.deb https://cdn.fastly.steamstatic.com/client/installer/steam.deb
    sudo dpkg -i ~/steam.deb
    sudo apt-get install -f
    rm steam.deb

    # Section for Proton Glorious Eggroll
    touch ~/.steam/root/compatibilitytools.d
    git https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton9-22/GE-Proton9-22.tar.gz
    tar -xf GE-Proton9-22.tar.gz  -C ~/.steam/root/compatibilitytools.d/
    rm  GE-Proton9-22.tar.gz

    # Section for discord (vesktop)
    wget -O vesktop.deb https://vencord.dev/download/vesktop/amd64/deb
    sudo dpkg -i vesktop.deb
    sudo apt-get install -f
    rm vesktop.deb

else
    # Continue if the user chooses no
    echo "Skipping gaming apps."
fi

# HACK TOOLS
read -p "Do you want to install hacking tools? (y/n): " user_input
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
    sudo apt install i3 dunst polybar ranger rofi feh flameshot redshift kitty
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E3CA1A89941C42E6
else
    echo "Skipping i3wm installation."
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




# FINAL UPDATE
echo "Updating and cleaning up..."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

echo "Post install complete."
