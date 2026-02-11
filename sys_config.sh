#!/bin/bash
cd ~/

# Updates the package index files and revises the list of available packages.  Does a full upgrade of the OS and it's accompanying apps.
echo "→ Updates the package index files and revises the list of available packages.  Does a full upgrade of the OS and it's accompanying apps"
echo ""
sudo apt update && sudo apt full-upgrade && sudo dpkg --configure -a && flatpak update -y

# Installs git onto the distro if not already present
sudo apt install git
echo ""

# Clones the system_configs repository onto the local system
# git clone https://github.com/crome1394/system-configs.git

# Downloads the ".bash_aliases" and replaces the file if present on the local system
echo "→ Downloads and replaces the .bash_aliases file from github"
echo ""
curl -fsSL https://raw.githubusercontent.com/crome1394/system-configs/main/.bash_aliases -o ~/.bash_aliases

# Sources the ".bash_aliases" by instructing bash to read and execute the file
echo "→ Sourcing the .bash_aliases"
echo ""
source ~/.bash_aliases

# Updates nano to automatically add line numbers and make them constantly show
echo "→ Updated nano to always show line numbers"
echo ""
mkdir ~/.config/nano
echo "set linenumbers" > ~/.config/nano/nanorc
echo "set constantshow" >> ~/.config/nano/nanorc
echo ""

# Replaces or creates the custom-images file adding wallpapers to cosmic-settings
echo "→ Replaces the custom-images with my favorite wallpapers"
echo ""
sudo cp --preserve=all ~/system-configs/custom-wallpapers/custom-images ~/.config/cosmic/com.system76.CosmicSettings.Wallpaper/v1/custom-images

# Replaces or create the "custom" file setting the custom keyboard shortcuts in cosmic-settings
echo "→ replaces the keyboard custom file my favorite keyboard shortcuts"
echo ""
sudo cp --preserve=all ~/system-configs/custom-keyboard-shortcuts/custom ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom

# Copies my favorite minimon config
sudo cp -R --preserve=all ~/system-configs/minimon/io.github.cosmic_utils.minimon-applet-panel/ /home/crome/.config/

# launches the system-configs github in firefox
firefox https://github.com/crome1394/system-configs & 

