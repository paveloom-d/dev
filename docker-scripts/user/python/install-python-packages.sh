#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling Python packages:\e[0m'

# Install wheel
echo '\e[1;36m> Installing wheel...\e[0m'
pip3 install --no-cache-dir wheel >/dev/null

# Install numpy
echo '\e[1;36m> Installing numpy...\e[0m'
pip3 install --no-cache-dir numpy >/dev/null

# Install matplotlib
echo '\e[1;36m> Installing matplotlib...\e[0m\n'
pip3 install --no-cache-dir matplotlib >/dev/null