#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling essential packages:\033[0m'

# Install git
echo -e '\e[1m\033[36m> Installing git...\033[0m'
apk add --no-cache git=2.26.2-r0 >/dev/null

# Install nano
echo -e '\e[1m\033[36m> Installing nano...\033[0m'
apk add --no-cache nano=4.9.3-r0 >/dev/null

# Install nano-syntax
echo -e '\e[1m\033[36m> Installing nano-syntax...\033[0m'
apk add --no-cache nano-syntax=4.9.3-r0 >/dev/null

# Install openssh
echo -e '\e[1m\033[36m> Installing openssh...\033[0m\n'
apk add --no-cache openssh=8.3_p1-r0 >/dev/null