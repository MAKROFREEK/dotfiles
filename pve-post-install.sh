#!/usr/bin/env bash

header_info() {
  clear
  cat <<"EOF"
       ______  _   _____________     ________   __   ____             __     ____           __        ____
      / / __ \/ | / / ____/ ___/    / / ____/  / /  / __ \____  _____/ /_   /  _/___  _____/ /_____ _/ / /
 __  / / / / /  |/ / __/  \__ \__  / / /      / /  / /_/ / __ \/ ___/ __/   / // __ \/ ___/ __/ __ `/ / / 
/ /_/ / /_/ / /|  / /___ ___/ / /_/ / /___   / /  / ____/ /_/ (__  ) /_   _/ // / / (__  ) /_/ /_/ / / /  
\____/\____/_/ |_/_____//____/\____/\____/  / /  /_/    \____/____/\__/  /___/_/ /_/____/\__/\__,_/_/_/   
                                           /_/                                                            
Proxmmox Post-Install Script - v0.0.1
EOF
}

# Remove Enterprise Repo

rm /etc/apt/sources.list.d/pve-enterprise.list
# msg_ok "Removed Proxmox Enterprise Repo"

# Add Free Repo
echo "deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/proxmox.list
# msg_ok "Added Proxmox Free Repo"

# Increase Storage
lvremove /dev/pve/data
lvresize -l +100%FREE /dev/pve/root
resize2fs /dev/mapper/pve-root
# msg_ok "Single Storage Increased to 100%" 

# Install Neovim
apt-get install neovim git fish fisher -y
# msg_ok "Installed Packages"

# Set preferences
export MANPAGER='nvim +Man!'
# msg_ok "Preferences set"

# Set fish as default shell
chsh -s /usr/bin/fish
# msg_ok "Set fish as default shell"