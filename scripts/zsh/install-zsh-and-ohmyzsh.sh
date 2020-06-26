#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling Zsh:\033[0m'

# Install the package
echo -e '\e[1m\033[36m> Installing the package...\033[0m'
apk add --no-cache zsh=5.8-r1 >/dev/null

# Change default shell
echo -e '\e[1m\033[36m> Changing default shell...\033[0m'
sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# Install OhMyZsh
echo -e '\e[1m\033[36m> Installing OhMyZsh...\033[0m'
(sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ) >/dev/null 2>&1

# Download zsh-autosuggestions plugin
echo -e '\e[1m\033[36m> Downloading zsh-autosuggestions plugin...\033[0m'
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null

# Activate the plugin
echo -e '\e[1m\033[36m> Activating the plugin...\033[0m'
sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions)' ~/.zshrc

# Activate zshcfg alias
echo -e '\e[1m\033[36m> Activating zshcfg alias...\033[0m\n'
sed -i '/# alias zshconfig="mate ~\/\.zshrc"/c\alias zshcfg="nano ~\/\.zshrc"' ~/.zshrc