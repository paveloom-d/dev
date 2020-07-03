#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mSetting up a user:\033[0m'

# Install sudo
echo -e '\e[1m\033[36m> Installing sudo...\033[0m'
apk add --no-cache sudo >/dev/null

# Create a new user
echo -e '\e[1m\033[36m> Adding a user...\033[0m'
adduser -D $USER

# Disable password prompt
echo -e '\e[1m\033[36m> Disabling password prompt...\033[0m'
echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

# Set read only mode for this file
echo -e '\e[1m\033[36m> Setting read only mode for /etc/sudoers.d/$USER...\033[0m'
chmod 0440 /etc/sudoers.d/$USER

# Let user own home directory
echo -e '\e[1m\033[36m> Letting new user to own home directory...\033[0m\n'
chown -R $USER:$USER $HOME