#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling Python packages:\033[0m'

# Install wheel
echo '\e[1m\033[36m> Installing wheel...\033[0m'
pip3 install --no-cache-dir wheel >/dev/null

# Install numpy
echo '\e[1m\033[36m> Installing numpy...\033[0m'
pip3 install --no-cache-dir numpy >/dev/null

# Install matplotlib
echo '\e[1m\033[36m> Installing matplotlib...\033[0m\n'
pip3 install --no-cache-dir matplotlib >/dev/null