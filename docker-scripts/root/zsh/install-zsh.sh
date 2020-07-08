#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling Zsh:\e[0m'

# Update lists of packages
echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

# Install the package
echo '\e[1;36m> Installing the package...\e[0m'
apt-get install -y --no-install-recommends zsh >/dev/null

# Change the default shell
echo '\e[1;36m> Changing the default shell...\e[0m'
sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# Clean the apt cache
echo '\e[1;36m> Cleaning the apt cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*