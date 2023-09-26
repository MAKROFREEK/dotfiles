#!/bin/bash


# copy folders
cp -r .config ~/.config
# copy background
cp -r .local ~/.local
# copy documents
cp -r documents ~/Documents
# install packages
bash post-install-scripts/install-timer.sh
bash post-install-scripts/get-packages.sh
