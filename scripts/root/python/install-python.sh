#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling Python:\033[0m'

# Update lists of packages
echo '\e[1m\033[36m> Updating lists of packages...\033[0m'
apt-get update >/dev/null

# Install python3-dev
echo '\e[1m\033[36m> Installing python3-dev...\033[0m'
apt-get install -y --no-install-recommends python3-dev >/dev/null

# Install python3-pip
echo '\e[1m\033[36m> Installing python3-pip...\033[0m'
apt-get install -y --no-install-recommends python3-pip >/dev/null

# Clean the apt cache
echo '\e[1m\033[36m> Cleaning the apt cache...\033[0m\n'
rm -rf /var/lib/apt/lists/*