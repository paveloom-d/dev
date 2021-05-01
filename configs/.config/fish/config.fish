# Go home
cd $HOME

# Disable greeting
set fish_greeting

# Key bindings

## Bind `Ctrl+Backspace` to delete a word behind the cursor
bind \b backward-kill-word

## Bind `Ctrl+Delete` to delete a word after the cursor
bind \e\[3\;5~ kill-word

# Variables

## Switch to UTF-8 encoding
set -gx LC_ALL C.UTF-8

## Make `less` not open a window if text takes up less space
set -gx LESS -FXR

## Set up the display (for WSL)
set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

# Aliases
alias ls=exa
alias cfg="nano ~/.config/fish/config.fish"

# Keychain
# eval keychain -q --noask --eval id_rsa >/dev/null
