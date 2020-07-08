#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling keychain:\e[0m'

# Update lists of packages
echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

# Install keychain
echo '\e[1;36m> Installing keychain...\e[0m'
apt-get install -y --no-install-recommends keychain >/dev/null

# Let the user own .keychain
echo '\e[1;36m> Letting the user own keychain...\e[0m'
chown -R $USER:$USER ~/.keychain

# Clean the apt cache
echo '\e[1;36m> Cleaning the apt cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*