# Dotfiles Post-Installation Script


Welcome to my Dotfiles Post-Installation Script repository! This script is my trusted companion for setting up my GNOME desktop environment exactly the way I like it after a fresh Linux installation. It's designed to automate the installation of packages, configure GNOME settings, and handle various tasks, all tailored to my specific GNOME setup. 

## Table of Contents

- [Features](#features)
- [Usage](#usage)
- [Scripts](#scripts)

## Features

- **Personalized GNOME Setup**: This script reflects my unique GNOME desktop preferences and setups, making it truly personal.
- **Efficiency**: It saves me valuable time by automating package installations, GNOME configuration, and more.
- **Documentation**: I can easily manage my documents and settings within the GNOME environment using the included scripts.
- **Adaptability**: I can customize the script whenever I need to adapt to changes in my GNOME workflow.


## Usage

1. Clone this repository to your local machine: (Feel free to change dots to whatever you want, I found this to be easiest to remember)

   ```bash

   git clone --bare https://github.com/MAKROFREEK/dotfiles.git ~/.dotfiles
   alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
   dots config status.showUntrackedFiles no
   dots checkout
   
2. Example of how to use after installing
   ```bash
   dots status
   dots add .vimrc
   dots commit -m "Add vimrc"
   dots add .bashrc
   dots commit -m "Add bashrc"
   dots push

## Scripts

    get-packages.sh: Installs essential packages and dependencies.
    gnome-settings.sh: Configures GNOME desktop settings in case dots get it wrong.
    install-timer.sh: Installs custom version of simple-timer-extension on gnome-extensions.


