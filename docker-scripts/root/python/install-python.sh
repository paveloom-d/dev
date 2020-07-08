#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling Python:\e[0m'

# Update lists of packages
echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

# Install python3-dev
echo '\e[1;36m> Installing python3-dev...\e[0m'
apt-get install -y --no-install-recommends python3-dev >/dev/null

# Install python3-pip
echo '\e[1;36m> Installing python3-pip...\e[0m'
apt-get install -y --no-install-recommends python3-pip >/dev/null

# Clean the apt cache
echo '\e[1;36m> Cleaning the apt cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*