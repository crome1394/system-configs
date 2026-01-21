# New LS
alias ls='ls -a --color=auto --group-directories-first --time-style=long-iso'

# keyboard speed up
alias kr='xset r rate 250 30' 

# Set Brave Browser
alias set_brave='xdg-settings set default-web-browser brave-browser.desktop'

# set Google Chrome Browser
alias set_chrome='xdg-settings set default-web-browser google-chrome.desktop'

# set both nvidia & power profile to Performance
alias gamemode='sudo nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" && system76-power profile performance'

# set both nvidia & power profile to Balanced
alias workmode='sudo nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=2" && system76-power profile balanced'

# Show active ports
alias port='netstat -tulanp'

# Application Shortcuts
alias obsidian='flatpak run md.obsidian.Obsidian'
alias ghb='sudo cpulimit -b -e ghb -l 750 && flatpak run fr.handbrake.ghb'
alias sc='/usr/bin/speedcrunch'
alias makemkv='flatpak run com.makemkv.MakeMKV'
alias authenticator='flatpak run com.belmoussaoui.Authenticator'
alias mkvtoolnix='flatpak run org.bunkus.mkvtoolnix-gui'
alias audacious='flatpak run org.atheme.audacious'
alias flatseal='flatpak run com.github.tchx84.Flatseal'
alias vs='flatpak run com.vscodium.codium'

# Counts the number of files
alias count="find . -type f | wc -l"

# Show a comprehensive visually structured overview of the entire prorcess hierarchy on the system
alias proc="ps -e --forest -o pid,ppid,user,etime,cmd | grep -E 'gnome|pop|cosmic|systemd'"

# Show my public IP
alias pubip="dig myip.opendns.com @resolver1.opendns.com | grep --color=always -E '([0-9]{1,3}\.){3}[0-9]{1,3}|$'"

# Tail all logs in /var/log
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

#Generate a random strong password
alias genpasswd="strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n'; echo"

# Shows the system temperatures in realtime.  
alias temps="watch -n 2 sensors"

# Show the IP addresses in color
alias ipca='ip -c a'

#Shortcut for Default Web Browser
web()   {
    brave-browser
        }

# Backup Home folders to rsync server NAS

profile_backup()   {

    # Backup Variables
    USERNAME=$(whoami)
    DATE=$(date +%Y%m%d)
    SOURCE="/home/${USERNAME}/"
    HOST="crome-nas"
    REMOTE_HOST="${USERNAME}@${HOST}"
    DEST_PATH="tera-b/backups/sys_backup_${DATE}"

# Perform the rsync backup with my exclusions
sudo rsync -avzh --info=progress2 \
    --exclude='.cache/' \
    --exclude='Downloads/' \
    --exclude='Pickup' \
    --exclude='.nv' \
    --exclude='.paradoxlauncher' \
    --exclude='.pki' \
    --exclude='.local/share/flatpak' \
    --exclude='.Trash-0' \
    --exclude='.Trash-1000' \
    "${SOURCE}" \
    "rsync://${REMOTE_HOST}/${DEST_PATH}/"
}

# Count the number of file types for a specific folder.  
function countfiletypes()  {
  if [[ $# ]]; then
    # broken down sed expression:
    # remove the beginning dot for hidden files
    # s/^\.(.*)/\1/;
    # do not delete lines possessing an extension
    # /.*\..*/!d;
    # capture the extension after the last '.'
    # s/.*\.(.+)/\1/
    find "$@" -type f -exec basename -a \{\} \+ | tr -d "\'" | sed 's/^\.\(.*\)/\1/;/.*\..*/!d;s/.*\.\(.\+\)/\1/' | sort | uniq -c
  else
    find . -type f -exec basename -a \{\} \+ | tr -d "\'" | sed 's/^\.\(.*\)/\1/;/.*\..*/!d;s/.*\.\(.\+\)/\1/' | sort | uniq -c
  fi
}


# Checking the size and number of files of a specific directory
dstats() {
    # Use the provided argument as the directory; default to current directory if none given
    local DIR="${1:-.}"

    # Validate that the directory exists
    if [[ ! -d "$DIR" ]]; then
        echo "Error: Directory '$DIR' does not exist or is not a directory." >&2
        return 1
    fi

    # Display the results
    echo "Directory: $DIR"
    echo "Total size: $(du -sh "$DIR" | cut -f1)"
    echo "File count: $(find "$DIR" -type f | wc -l)"
}


# Update the OS & do the flatpaks
#alias updateos='sudo apt clean && sudo apt update && sudo apt full-upgrade -y && flatpak update -y && sudo apt autoremove && sudo dpkg --configure -a'

updateos() {
    echo "────────────────────────────────────────────────────────────────────────────────────────────────────────────────"
    echo "Starting full system maintenance..."
    echo "Commands that will run:"
    echo "  • sudo apt update"
    echo "  • sudo apt full-upgrade"
    echo "  • sudo apt autoremove"
    echo "  • sudo apt autoclean"
    echo "  • sudo dpkg --configure -a"
    echo "  • flatpak update"
    echo "  • fwupdmgr firmware refresh & update (if available)"
    echo "────────────────────────────────────────────────────────────────────────────────────────────────────────────────"
    echo ""

    # 1. apt update
    echo "→ Running: sudo apt update"
    if sudo apt update; then
        echo "✔ apt update succeeded"
    else
        echo "✘ apt update failed – stopping here (fix sources/network and retry)"
        return 1
    fi
    echo ""

#    # New: Show what is actually going to be upgraded (very useful feedback)
#    echo "→ Packages that can be upgraded after this update:"
#    apt list --upgradable | grep -v '^Listing... ' || echo "  (none found)"
#    echo ""

    # 2. apt full-upgrade
    echo "→ Running: sudo apt full-upgrade"
    if sudo apt full-upgrade; then
        echo "✔ Full upgrade completed"
    else
        echo "✘ Upgrade failed – you may need to investigate manually"
        echo "  Common fixes: run 'sudo apt update' again or check for held packages with 'apt-mark showhold'"
    fi
    echo ""

    # 3. apt autoremove
    echo "→ Running: sudo apt autoremove"
    if sudo apt autoremove; then
        echo "✔ Removed unnecessary packages"
    else
        echo "✘ autoremove encountered an issue (usually non-fatal)"
    fi
    echo ""

    # 4. apt autoclean
    echo "→ Running: sudo apt autoclean"
    if sudo apt autoclean; then
        echo "✔ Cleared old downloaded package cache"
    else
        echo "✘ autoclean failed (rare – check disk space/permissions)"
    fi
    echo ""

    # 5. dpkg --configure -a (fixes interrupted/broken package configurations)
    echo "→ Running: sudo dpkg --configure -a"
    if sudo dpkg --configure -a; then
        echo "✔ Fixed any pending package configurations"
    else
        echo "✘ dpkg configure failed – serious issue, investigate manually (look at output above)"
    fi
    echo ""

    # 6. flatpak update (non-sudo, but may ask for password if needed for some remotes)
    if command -v flatpak >/dev/null 2>&1; then
        echo "→ Running: flatpak update"
        if flatpak update -y; then
            echo "✔ Flatpak apps updated"
        else
            echo "✘ Flatpak update failed – check Flatpak installation, remotes, or network"
        fi
    else
        echo "→ Flatpak not installed – skipping flatpak update"
    fi
    echo ""

    # New: Firmware updates (BIOS, SSD, Thunderbolt, peripherals, etc.)
    if command -v fwupdmgr >/dev/null 2>&1; then
        echo "→ Running: fwupdmgr firmware check & update"
        echo "  (this handles BIOS/UEFI, device firmware from LVFS – may require reboot afterward)"
        
        # Refresh metadata (force helps when cache is stale)
        sudo fwupdmgr refresh --force >/dev/null 2>&1 || echo "  i  Metadata refresh had minor issue (often harmless if offline)"
        
        if sudo fwupdmgr update; then
            echo "✔ Firmware check complete (updates applied if any were available)"
        else
            echo "✘ fwupdmgr reported issues or no updates applied"
            echo "  → Common: no new firmware, network problem, or device not supported"
            echo "  → You can run 'fwupdmgr get-updates' manually for more detail"
        fi
    else
        echo "→ fwupdmgr not found – skipping firmware updates"
        echo "  (install with: sudo apt install fwupd   if you want hardware firmware support)"
    fi
    echo ""

    echo "────────────────────────────────────────────────────────────────────────────────────────────────────────────────"
    echo "System maintenance complete!"

    # New: Reboot recommendation – the standard way on Pop!_OS / Ubuntu derivatives
    if [ -f /var/run/reboot-required ]; then
        echo ""
        echo "⚠ REBOOT RECOMMENDED"
        echo "The following updates likely require a restart to take full effect:"
        if [ -f /var/run/reboot-required.pkgs ]; then
            cat /var/run/reboot-required.pkgs | sed 's/^/  • /'
        else
            echo "  • (list of triggering packages not available)"
        fi
        echo ""
        echo "→ Common triggers: new kernel, NVIDIA drivers, systemd, libc, firmware"
    else
        echo "No reboot appears necessary right now."
    fi

    echo ""
    echo "Tip: After important updates (especially kernel/firmware), reboot even if not strictly required."
    echo "────────────────────────────────────────────────────────────────────────────────────────────────────────────────"
}

# I wanted to create a help function to show the number of aliases and functions.  

help() {
    cat << 'EOF'

Bash Aliases Help
===================

HELP           : Shows this help
DSTATS         : Checking the size and number of files of a specific directory
PROFILE_BACKUP : Backs up the current user' profile to tera-b
WEB            : Starts Brave Browser
TEMPS          : Shows the system & CPU temperatures in real time
GENPASSWD      : Generates a random password
LOGS           : Shows the /var/log directory and subdirectories in realtime
UPDATEOS       : Updates the OS
FLATSEAL       : Starts Flatseal
AUDACIOUS      : Starts Audacious
MAKEMKV        : Starts MakeMKV
SC             : Starts SpeedCrunch
GHB            : Starts handbrake & set CPU to 75%
OBSIDIAN       : Starts Obsidian
PORT           : Shows the network sockets, with a focus on listening ports and associated processes
GAMEMODE       : Sets Nvidia & CPU to performance
WORKMODE       : Sets Nvidia & CPU to balanced
SET_CHROME     : Sets Chrome as the default browser
SET_BRAVE      : Sets Brave as the default browser
KR             : Set the keyboard rate
COUNT          : Count the number of files 
IPCA           : Show the IPs, MAC Addresses & Adapters in Color
PROC           : Show a comprehensive visually structured overview of the entire prorcess hierarchy on the system
PUBIP          : Shows my Public IP

EOF
}
