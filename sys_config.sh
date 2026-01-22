#!/bin/bash
cd ~/

# Updates the package index files and revises the list of available packages.  Does a full upgrade of the OS and it's accompanying apps.
sudo apt update && sudo apt full-upgrade

# Installs git onto the distro if not already present
sudo apt get git

# Clones the system_configs repository onto the local system
git clone https://github.com/crome1394/system-configs.git
# Downloads the ".bash_aliases" and replaces the file if present on the local system
curl -fsSL https://raw.githubusercontent.com/crome1394/system-configs/main/.bash_aliases -o ~/.bash_aliases

# Sources the ".bash_aliases" by instructing bash to read and execute the file
source ~/.bash_aliases

# Updates nano to automatically add line numbers and make them constantly show
mkdir ~/.config/nano
echo "set linenumbers" > ~/.config/nano/nanorc
echo "set constantshow" >> ~/.config/nano/nanorc

# Replaces or creates the custom-images file adding wallpapers to cosmic-settings
sudo cp ~/system-configs/custom-wallpapers/custom-images ~/.config/cosmic/com.system76.CosmicSettings.Wallpaper/v1/custom-images

# Replaces or create the "custom" file setting the custom keyboard shortcuts in cosmic-settings
sudo cp ~/system-configs/custom-keyboard-shortcuts/custom ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom

# launches the system-configs github in firefox
firefox https://github.com/crome1394/system-configs & 
