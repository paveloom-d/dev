#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling OhMyZsh:\033[0m'

# Install OhMyZsh
echo '\e[1m\033[36m> Installing OhMyZsh...\033[0m'
(sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ) >/dev/null 2>&1

# Download zsh-autosuggestions plugin
echo '\e[1m\033[36m> Downloading zsh-autosuggestions plugin...\033[0m'
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null

# Activate the plugin
echo '\e[1m\033[36m> Activating the plugin...\033[0m'
sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions)' ~/.zshrc

# Activate zshcfg alias
echo '\e[1m\033[36m> Activating zshcfg alias...\033[0m'
sed -i '/# alias zshconfig="mate ~\/\.zshrc"/c\alias zshcfg="nano ~\/\.zshrc"' ~/.zshrc

# Change colors of public directories
echo '\e[1m\033[36m> Appending custom config changes...\033[0m'
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

# Other

## Fixing TTY for GPG
export GPG_TTY=$(tty)

## Starting a ssh-agent
eval "$(ssh-agent -s)" > /dev/null 2>&1' >> ~/.zshrc

# Create a theme
echo '\e[1m\033[36m> Creating a theme...\033[0m'
echo 'PROMPT="%(?:%{$fg_bold[green]%}~>:%{$fg_bold[red]%}~>)"
PROMPT+='\'' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'\''

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}<"
ZSH_THEME_GIT_PROMPT_SUFFIX=">%{$reset_color%} "' > ~/.oh-my-zsh/custom/themes/paveloom.zsh-theme

# Change the theme
echo '\e[1m\033[36m> Changing the theme...\033[0m'
sed -i '/ZSH_THEME="robbyrussell"/c\ZSH_THEME="paveloom"' ~/.zshrc

# Activate nano's default syntax highlighting
echo '\e[1m\033[36m> Activating nano'\''s default syntax highlighting...\033[0m'
echo 'include /usr/share/nano/*.nanorc' > ~/.nanorc

# Add some configuration before sourcing
echo '\e[1m\033[36m> Adding some configuration before sourcing...\033[0m\n'
sed -i '/source $ZSH\/oh-my-zsh./c\
# Change colors of public directories\
export LS_COLORS="$LS_COLORS:di=1;34:ow=1;31:tw=1;31:"\
\
# Disable verification of insecure directories\
ZSH_DISABLE_COMPFIX="true"\
\
source $ZSH/oh-my-zsh.sh' ~/.zshrc