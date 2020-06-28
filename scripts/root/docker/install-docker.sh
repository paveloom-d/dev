#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling docker:\033[0m'

# Install the package
echo -e '\e[1m\033[36m> Installing the package...\033[0m'
apk add --no-cache docker=19.03.11-r0 >/dev/null

# Add the user to the docker group
echo -e '\e[1m\033[36m> Adding user to the docker group...\033[0m\n'
sudo usermod -aG docker $USER