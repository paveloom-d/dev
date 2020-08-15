#!/bin/sh

# Print info
echo '\n\e[1;36mSetting up a user:\e[0m'

# Add a new user
echo '\e[1;36m> Adding a user...\e[0m'
useradd -ms /bin/bash $USER

# Disable password prompt
echo '\e[1;36m> Disabling password prompt...\e[0m'
echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

# Set read only mode for this file
echo '\e[1;36m> Setting read only mode for /etc/sudoers.d/$USER...\e[0m'
chmod 0440 /etc/sudoers.d/$USER

# Let the user own home directory
echo '\e[1;36m> Letting the user to own home directory...\e[0m\n'
chown -R $USER:$USER $HOME