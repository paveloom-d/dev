#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling Node.js and npm:\e[0m'

# Update lists of packages
echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

# Install Node.js
echo '\e[1;36m> Installing Node.js...\e[0m'
apt-get install -y --no-install-recommends nodejs >/dev/null

# Install npm
echo '\e[1;36m> Installing npm...\e[0m'
apt-get install -y --no-install-recommends npm >/dev/null

# Clean the apt cache
echo '\e[1;36m> Cleaning the apt cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*