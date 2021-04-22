#!/bin/bash

echo -e '\n\e[1;36mInstalling OhMyZsh:\e[0m'

echo -e '\e[1;36m> Installing the framework...\e[0m'
(sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)") >/dev/null 2>&1

echo -e '\e[1;36m> Downloading the `zsh-autosuggestions` plugin...\e[0m'
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null

echo -e '\e[1;36m> Activating the plugin...\e[0m'
sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions)' ~/.zshrc

echo -e '\e[1;36m> Activating `zshcfg` alias...\e[0m'
sed -i '/# alias zshconfig="mate ~\/\.zshrc"/c\alias zshcfg="nano ~\/\.zshrc"' ~/.zshrc

echo -e '\e[1;36m> Appending custom config changes...\e[0m'
echo '
# Key bindings

## Bind `Ctrl+Backspace` to delete a word behind the cursor
bindkey '\''^H'\'' backward-kill-word

## Bind `Ctrl+Delete` to delete a word after the cursor
bindkey '\''5~'\'' kill-word

# Settings for the `zsh-autosuggestions` plugin

## Change the color of a suggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff"

# Theme settings

## Change colors of public directories in the `ls` output
export LS_COLORS="$LS_COLORS:ow=1;35:tw=1;35:"

# SSH / Keychain

## Start an `ssh-agent`
eval "$(ssh-agent -s)" >/dev/null 2>&1

## Start SSH service
sudo service ssh start >/dev/null

## Add an SSH key to the keys chain
# keychain ~/.ssh/id_rsa 2>/dev/null
# . ~/.keychain/`uname -n`-sh

# Other

## Fix `TTY` for GPG
export GPG_TTY=$(tty)

## Activate the Russian locale
export LC_CTYPE=ru_RU.UTF8

## Make `less` not open a window
## if text takes up less space
export LESS=-FXR

## Go home at the start
cd $HOME' >> ~/.zshrc

echo -e '\e[1;36m> Creating a theme...\e[0m'
echo 'PROMPT="%(?:%{$fg_bold[green]%}~>:%{$fg_bold[red]%}~>)"
PROMPT+='\'' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'\''

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}<"
ZSH_THEME_GIT_PROMPT_SUFFIX=">%{$reset_color%} "' > ~/.oh-my-zsh/custom/themes/paveloom.zsh-theme

echo -e '\e[1;36m> Adjusting the theme...\e[0m'
sed -i '/ZSH_THEME="robbyrussell"/c\ZSH_THEME="paveloom"' ~/.zshrc

echo -e '\e[1;36m> Activating `nano`'\''s default syntax highlighting...\e[0m'
echo 'include /usr/share/nano/*.nanorc' > ~/.nanorc

echo -e '\e[1;36m> Adding the configuration before sourcing...\e[0m'
sed -i '/source $ZSH\/oh-my-zsh./c\
# Change the colors of public directories\
export LS_COLORS="$LS_COLORS:di=1;34:ow=1;31:tw=1;31:"\
\
# Disable the verification of insecure directories\
ZSH_DISABLE_COMPFIX="true"\
\
source $ZSH/oh-my-zsh.sh' ~/.zshrc

echo
