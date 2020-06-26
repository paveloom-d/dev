#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling Zsh:\033[0m'

# Install the package
echo -e '\e[1m\033[36m> Installing the package...\033[0m'
apk add --no-cache zsh=5.8-r1 >/dev/null

# Change default shell
echo -e '\e[1m\033[36m> Changing default shell...\033[0m\n'
sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd