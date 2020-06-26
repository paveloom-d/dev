#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling OhMyZsh:\033[0m'

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
echo -e '\e[1m\033[36m> Activating zshcfg alias...\033[0m'
sed -i '/# alias zshconfig="mate ~\/\.zshrc"/c\alias zshcfg="nano ~\/\.zshrc"' ~/.zshrc

# Change colors of public directories
echo -e '\e[1m\033[36m> Appending custom config changes...\033[0m'
echo '
# Change colors of public directories
export LS_COLORS="$LS_COLORS:ow=1;35:tw=1;35:"

# Changing display
export DISPLAY=localhost:0.0

# Fixing GPG
export GPG_TTY=$(tty)

# Starting ssh-agent
eval "$(ssh-agent -s)" > /dev/null 2>&1' >> ~/.zshrc

# Copy default theme
echo -e '\e[1m\033[36m> Copying default theme...\033[0m\n'
cp ~/.oh-my-zsh/themes/robbyrussell.zsh-theme ~/.oh-my-zsh/custom/themes/paveloom.zsh-theme