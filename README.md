# System Configurations

This repository contains sanitized system files for reference:
- fstab: Filesystem table
- hosts: Hosts file
- cosmic-themes: Cosmic desktop themes
- wallpapers: Background images
- authenticator-icons: Icons for authenticator apps
- nanorc:  Adds line numbers to nano by default.  Copy the "nanorc" file to ~/.config/nano/
- common_flatpaks: List of useful flatpaks
- common_packages: List of system packages to install
- bash_aliases:  a list of useful aliases and functions
	- HELP           : Shows this help
	- DSTATS         : Checking the size and number of files of a specific directory
	- PROFILE_BACKUP : Backs up the current user' profile to tera-b
	- WEB            : Starts Brave Browser
	- TEMPS          : Shows the system & CPU temperatures in real time
	- GENPASSWD      : Generates a random password
	- LOGS           : Shows the /var/log directory and subdirectories in realtime
	- UPDATEOS       : Updates the OS
	- FLATSEAL       : Starts Flatseal
	- AUDACIOUS      : Starts Audacious
	- MAKEMKV        : Starts MakeMKV
	- SC             : Starts SpeedCrunch
	- GHB            : Starts handbrake & set CPU to 75%
	- OBSIDIAN       : Starts Obsidian
	- PORT           : Shows the network sockets, with a focus on listening ports and associated processes
	- GAMEMODE       : Sets Nvidia & CPU to performance
	- WORKMODE       : Sets Nvidia & CPU to balanced
	- SET_CHROME     : Sets Chrome as the default browser
	- SET_BRAVE      : Sets Brave as the default browser
	- KR             : Set the keyboard rate
	- COUNT          : Count the number of files
	- IPCA           : Show the IPs, MAC Addresses & Adapters in Color
	- PROC           : Show a comprehensive visually structured overview of the entire prorcess hierarchy on the system
	- PUBIP          : Shows my Public IP

```bash
## Usage
Copy files to your system with caution and adapt as needed.

# Download Directly
curl -fsSL https://raw.githubusercontent.com/crome1394/system-configs/main/.bash_aliases -o ~/.bash_aliases

# Execute the following to update nano
mkdir ~/.config/nano
echo "set linenumbers" > ~/.config/nano/nanorc
echo "set constantshow" >> ~/.config/nano/nanorc

# Custom Wallpapers:  Commit the "custom-images" file to the following file
sudo nano ~/.config/cosmic/com.system76.CosmicSettings.Wallpaper/v1/custom-images

# Keyboard Shortcuts:  Commit the the "custom" file in the following file
sudo nano ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
