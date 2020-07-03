#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling Python:\033[0m'

# Install libzmq
echo -e '\e[1m\033[36m> Installing libzmq...\033[0m'
apk add --no-cache libzmq@v3.10 >/dev/null

# Install py3-pyzmq
echo -e '\e[1m\033[36m> Installing py3-pyzmq...\033[0m'
apk add --no-cache py3-pyzmq >/dev/null

# Install python3
echo -e '\e[1m\033[36m> Installing python3...\033[0m'
apk add --no-cache python3 >/dev/null

# Install pip3
echo -e '\e[1m\033[36m> Installing pip3...\033[0m\n'
apk add --no-cache py3-pip >/dev/null