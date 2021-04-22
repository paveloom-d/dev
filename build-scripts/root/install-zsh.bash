#!/bin/bash

echo -e '\n\e[1;36mInstalling Zsh:\e[0m'

# echo -e '\e[1;36m> Updating lists of packages...\e[0m'
# apt-get update >/dev/null

echo -e '\e[1;36m> Installing the package...\e[0m'
install_packages zsh

echo -e '\e[1;36m> Changing the default shell...\e[0m'
sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# echo -e '\e[1;36m> Cleaning the `apt` cache...\e[0m\n'
# rm -rf /var/lib/apt/lists/*

echo -e '\n'
