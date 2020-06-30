#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling JupyterLab:\033[0m'

# Add ~/.local/bin to the PATH
echo -e '\e[1m\033[36m> Adding ~/.local/bin to the PATH...\033[0m'
echo '
# JupyterLab

# Add ~/.local/bin to the PATH
export PATH=$PATH:/home/$USER/.local/bin' >> ~/.zshrc
export PATH=$PATH:/home/$USER/.local/bin

# Install wheel
echo -e '\e[1m\033[36m> Installing wheel...\033[0m'
pip3 install --no-cache-dir wheel==0.34.2 >/dev/null

# Install jupyter
echo -e '\e[1m\033[36m> Installing jupyter...\033[0m'
pip3 install --no-cache-dir jupyter==1.0.0 >/dev/null

# Install jupyterlab
echo -e '\e[1m\033[36m> Installing jupyterlab...\033[0m\n'
pip3 install --no-cache-dir jupyterlab==2.1.5 >/dev/null