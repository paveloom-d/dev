#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling Python:\033[0m'

# Install the package
echo -e '\e[1m\033[36m> Installing python3...\033[0m'
apk add --no-cache py3-pyzmq=18.1.1-r0 >/dev/null

# Install pip3
echo -e '\e[1m\033[36m> Installing pip3...\033[0m\n'
apk add --no-cache py3-pip=20.1.1-r0 >/dev/null