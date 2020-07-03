#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling essential packages:\033[0m'

# Install bash
echo -e '\e[1m\033[36m> Installing bash...\033[0m'
apk add --no-cache bash >/dev/null

# Install git
echo -e '\e[1m\033[36m> Installing git...\033[0m'
apk add --no-cache git >/dev/null

# Install nano
echo -e '\e[1m\033[36m> Installing nano...\033[0m'
apk add --no-cache nano >/dev/null

# Install nano-syntax
echo -e '\e[1m\033[36m> Installing nano-syntax...\033[0m'
apk add --no-cache nano-syntax >/dev/null

# Install openssh
echo -e '\e[1m\033[36m> Installing openssh...\033[0m'
apk add --no-cache openssh >/dev/null

# Install shadow
echo -e '\e[1m\033[36m> Installing shadow...\033[0m\n'
apk add --no-cache shadow >/dev/null