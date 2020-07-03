#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling JupyterLab:\033[0m'

# Install wheel
echo -e '\e[1m\033[36m> Installing wheel...\033[0m'
pip3 install --no-cache-dir wheel >/dev/null

# Install jupyter
echo -e '\e[1m\033[36m> Installing jupyter...\033[0m'
pip3 install --no-cache-dir jupyter >/dev/null

# Install jupyterlab
echo -e '\e[1m\033[36m> Installing jupyterlab...\033[0m'
pip3 install --no-cache-dir jupyterlab >/dev/null

# Add aliases for running a notebook server
echo -e '\e[1m\033[36m> Adding aliases for running a notebook server...\033[0m\n'
echo '
# Aliases for running a notebook server
alias jnote="jupyter notebook --ip 0.0.0.0 --no-browser"
alias jlab="jupyter lab --ip 0.0.0.0 --no-browser"' >> ~/.zshrc