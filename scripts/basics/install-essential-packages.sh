#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling essential packages:\033[0m'

# Install git
echo -e '\e[1m\033[36m> Installing git...\033[0m'
apk add --no-cache git=2.26.2-r0 >/dev/null

echo -e '\e[1m\033[36m> Installing nano...\033[0m\n'
# Install nano
apk add --no-cache nano=4.9.3-r0 >/dev/null