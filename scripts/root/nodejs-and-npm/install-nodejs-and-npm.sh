#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling Node.js and npm:\033[0m'

# Update lists of packages
echo '\e[1m\033[36m> Updating lists of packages...\033[0m'
apt-get update >/dev/null

# Install Node.js
echo '\e[1m\033[36m> Installing Node.js...\033[0m'
apt-get install -y --no-install-recommends nodejs >/dev/null

# Install npm
echo '\e[1m\033[36m> Installing npm...\033[0m'
apt-get install -y --no-install-recommends npm >/dev/null

# Clean the apt cache
echo '\e[1m\033[36m> Cleaning the apt cache...\033[0m\n'
rm -rf /var/lib/apt/lists/*