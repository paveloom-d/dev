#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling Zsh:\033[0m'

# Update lists of packages
echo '\e[1m\033[36m> Updating lists of packages...\033[0m'
apt-get update >/dev/null

# Install the package
echo '\e[1m\033[36m> Installing the package...\033[0m'
apt-get install -y --no-install-recommends zsh >/dev/null

# Change the default shell
echo '\e[1m\033[36m> Changing the default shell...\033[0m'
sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# Clean the apt cache
echo '\e[1m\033[36m> Cleaning the apt cache...\033[0m\n'
rm -rf /var/lib/apt/lists/*