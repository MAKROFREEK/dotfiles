#!/bin/bash
set -e  # Exit on any error


## REQUIREMENTS
sudo apt-get install git curl wget -y

### THEMES
# Download latest dracula
git clone https://github.com/dracula/gtk
cp -r gtk ~/.themes/Dracula
rm -rf gtk

## ICONS
wget https://github.com/dpejoh/Adwaita-colors/releases/download/v2.4.1/adwaita-colors-theme-2.4.1.deb
sudo dpkg -i adwaita-colors-theme-2.4.1.deb

# Apply GNOME theme settings
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita-Brown'

## BACKGROUNDS
./get-backgrounds.sh


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
    rm nvim-linux64.tar.gz
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

read -p "Do you want to install packages from packages-list? (y/n): " response
if [[ "$response" =~ ^[Yy](es)?$ ]]; then
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
else
    echo "Skipping package installation."
fi


## TERMINAL
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 100
sudo update-alternatives --config x-terminal-emulator


## Desktop Gaming
read -p "Will you be gaming with this setup? (y/n): " user_input
if [[ "$user_input" =~ ^[Yy](es)?$ ]]; then
    echo "Setting up gaming tools..."
    # Section for Spotify
    curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo tee /etc/apt/trusted.gpg.d/spotify.gpg > /dev/null
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update
    sudo apt-get install spotify-client -y

    # Section for Steam
    wget -O steam.deb https://cdn.akamai.steamstatic.com/client/installer/steam.deb
    sudo dpkg -i steam.deb || sudo apt-get install -f -y
    rm steam.deb

    # Section for Proton Glorious Eggroll
    mkdir -p ~/.steam/root/compatibilitytools.d
    wget -O GE-Proton9-22.tar.gz https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton9-22/GE-Proton9-22.tar.gz
    tar -xf GE-Proton9-22.tar.gz -C ~/.steam/root/compatibilitytools.d/
    rm GE-Proton9-22.tar.gz

    # Section for Discord (Vesktop)
    wget -O vesktop.deb https://vencord.dev/download/vesktop/amd64/deb
    sudo dpkg -i vesktop.deb || sudo apt-get install -f -y
    rm vesktop.deb
    
else
    echo "Skipping gaming apps."
fi


## HACK TOOLS
read -p "Do you want to install hacking tools? (y/n): " user_input
if [[ "$user_input" =~ ^[Yy](es)?$ ]]; then
    echo "Running the hackpack installation..."
    ./.config/hack-pack/dl_packages.sh
else
    echo "Skipping the hackpack installation."
fi


## i3wm
read -p "Do you want to install i3wm and set up auto-tiling? (y/n): " i3wm_setup
if [[ "$i3wm_setup" =~ ^[Yy](es)?$ ]]; then
    echo "Installing i3wm and configuring auto-tiling..."
    pip3 install i3ipc
    # Install latest version of i3wm
    wget https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb
    sudo apt install ./sur5r-keyring_2024.03.04_all.deb
    rm sur5r-keyring_2024.03.04_all.deb

    echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
    sudo apt update
    sudo apt install -y i3 dunst polybar ranger rofi feh flameshot redshift kitty lxappearance
else
    echo "Skipping i3wm installation."
fi


## FONTS
read -p "Do you want to install Nerd Fonts? (y/n): " nerd_fonts
if [[ "$nerd_fonts" =~ ^[Yy](es)?$ ]]; then
    echo "Setting up Nerd Fonts..."
    ./nerd-fonts.sh
else
    echo "Skipping Nerd Fonts installation."
fi

### FILES & DIRECTORIES
## CONFIG
cp -r .config/ ~/.config
## LOCAL
cp -r .local/ ~/.local

## FINAL UPDATE
echo "Updating and cleaning up..."
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y

echo "Post install complete."
