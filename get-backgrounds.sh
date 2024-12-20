#!/bin/bash



# clone backgrounds
git clone https://github.com/makrofreek/backgrounds
# move dirs
cd backgrounds
# copy bgs
mkdir ~/Pictures/Backgrounds
cp -r /Pixel Art ~/Pictures/Backgrounds
#set bg
# gsettings set org.gnome.desktop.background picture-uri file:///home/$USER/Backgrounds/1298880.png
# remove repo
rm -rf /backgrounds
