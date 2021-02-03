#!/bin/bash

echo -e '\n\e[1;36mInstalling Python packages:\e[0m'

echo -e '\e[1;36m> Explicitly updating the PATH variable in the `~/.zshrc`...\e[0m'
echo '
# Add Python'\''s default User Script Directory to the `PATH`
export PATH=$PATH:/home/$USER/.local/bin' >> ~/.zshrc

echo -e '\e[1;36m> Installing `wheel`...\e[0m'
pip3 install --no-cache-dir wheel >/dev/null

echo -e '\e[1;36m> Installing `numpy`...\e[0m'
pip3 install --no-cache-dir numpy >/dev/null

echo -e '\e[1;36m> Installing `matplotlib`...\e[0m\n'
pip3 install --no-cache-dir matplotlib >/dev/null
