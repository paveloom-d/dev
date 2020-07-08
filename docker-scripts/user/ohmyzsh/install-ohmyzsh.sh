#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling OhMyZsh:\e[0m'

# Install OhMyZsh
echo '\e[1;36m> Installing OhMyZsh...\e[0m'
(sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ) >/dev/null 2>&1

# Download zsh-autosuggestions plugin
echo '\e[1;36m> Downloading zsh-autosuggestions plugin...\e[0m'
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null

# Activate the plugin
echo '\e[1;36m> Activating the plugin...\e[0m'
sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions)' ~/.zshrc

# Activate zshcfg alias
echo '\e[1;36m> Activating zshcfg alias...\e[0m'
sed -i '/# alias zshconfig="mate ~\/\.zshrc"/c\alias zshcfg="nano ~\/\.zshrc"' ~/.zshrc

# Change colors of public directories
echo '\e[1;36m> Appending custom config changes...\e[0m'
echo '
# Key bindings

## Bind Ctrl+Backspace to delete a word behind the cursor
bindkey '\''^H'\'' backward-kill-word

## Bind Ctrl+Delete to delete a word after the cursor
bindkey '\''5~'\'' kill-word

# Settings for zsh-autosuggestions plugin

## Change the color of a suggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff"

# Theme settings

## Change colors of public directories in the `ls` output
export LS_COLORS="$LS_COLORS:ow=1;35:tw=1;35:"

# SSH / Keychain

## Starting a ssh-agent
eval "$(ssh-agent -s)" >/dev/null 2>&1

## Start ssh service
sudo service ssh start >/dev/null

## Add an SSH key to keychain
# keychain ~/.ssh/id_rsa 2>/dev/null
# . ~/.keychain/`uname -n`-sh

# Other

## Fixing TTY for GPG
export GPG_TTY=$(tty)' >> ~/.zshrc

# Create a theme
echo '\e[1;36m> Creating a theme...\e[0m'
echo 'PROMPT="%(?:%{$fg_bold[green]%}~>:%{$fg_bold[red]%}~>)"
PROMPT+='\'' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'\''

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}<"
ZSH_THEME_GIT_PROMPT_SUFFIX=">%{$reset_color%} "' > ~/.oh-my-zsh/custom/themes/paveloom.zsh-theme

# Change the theme
echo '\e[1;36m> Changing the theme...\e[0m'
sed -i '/ZSH_THEME="robbyrussell"/c\ZSH_THEME="paveloom"' ~/.zshrc

# Activate nano's default syntax highlighting
echo '\e[1;36m> Activating nano'\''s default syntax highlighting...\e[0m'
echo 'include /usr/share/nano/*.nanorc' > ~/.nanorc

# Add some configuration before sourcing
echo '\e[1;36m> Adding some configuration before sourcing...\e[0m\n'
sed -i '/source $ZSH\/oh-my-zsh./c\
# Change colors of public directories\
export LS_COLORS="$LS_COLORS:di=1;34:ow=1;31:tw=1;31:"\
\
# Disable verification of insecure directories\
ZSH_DISABLE_COMPFIX="true"\
\
source $ZSH/oh-my-zsh.sh' ~/.zshrc