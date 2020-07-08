#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling Rclone:\e[0m'

# Update lists of packages
echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

# Install the package
echo '\e[1;36m> Installing the package...\e[0m'
apt-get install -y --no-install-recommends rclone >/dev/null

# Clean the apt cache
echo '\e[1;36m> Cleaning the apt cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*