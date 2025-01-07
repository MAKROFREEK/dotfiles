#!/bin/bash



# Clone the repository
git clone https://github.com/makrofreek/backgrounds

# Navigate to the "backgrounds" directory
cd backgrounds

# Create a folder to store backgrounds
mkdir -p ~/Pictures/Backgrounds

# Copy the "Pixel Art" folder into the new location
cp -r "Pixel Art" ~/Pictures/Backgrounds

# Set the desktop background (replace with your desired image file)
gsettings set org.gnome.desktop.background picture-uri file:///home/$USER/Pictures/Backgrounds/1298880.png

# Remove the cloned repository
rm -rf ~/backgrounds
