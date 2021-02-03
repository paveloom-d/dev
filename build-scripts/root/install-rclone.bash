#!/bin/bash

echo -e '\n\e[1;36mInstalling Rclone:\e[0m'

echo -e '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

echo -e '\e[1;36m> Installing the package...\e[0m'
apt-get install -y --no-install-recommends rclone >/dev/null

echo -e '\e[1;36m> Cleaning the `apt` cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*
