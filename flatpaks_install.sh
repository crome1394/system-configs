#!/bin/bash
while read -r app; do 
	flatpak install --user "$app" -y
done < flatpak_app_list
