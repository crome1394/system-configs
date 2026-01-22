#!/bin/bash
sudo apt update
while read -r app; do 
	sudo apt install "$app" -y
done < apt_app_list
