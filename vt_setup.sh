#!/bin/bash
# Copying the new console-setup file that will accomadate an Ultrawide monitor
sudo cp /etc/default/console-setup console-setup.bak
sudo cp console-setup/console-setup /etc/default/console-setup
