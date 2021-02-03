#!/bin/bash

echo -e '\n\e[1;36mActivating the configuration for Rclone:\e[0m'

echo -e '\e[1;36m> `touch`ing `~/.config/rclone/rclone.conf`...\e[0m\n'
mkdir -p ~/.config/rclone
touch ~/.config/rclone/rclone.conf
