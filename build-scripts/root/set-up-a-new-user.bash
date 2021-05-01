#!/bin/bash

echo -e '\n\e[1;36mSetting up a user:\e[0m'

echo -e '\e[1;36m> Adding a user...\e[0m'
useradd -ms /usr/bin/fish $USER

echo -e '\e[1;36m> Disabling the password prompt...\e[0m'
echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

echo -e '\e[1;36m> Setting read-only mode for `/etc/sudoers.d/$USER`...\e[0m'
chmod 0440 /etc/sudoers.d/$USER

echo -e '\e[1;36m> Letting the user to own the home directory...\e[0m'
chown -R $USER:$USER $HOME

echo -e '\e[1;36m> Creating `/etc/wsl.conf`...\e[0m'
echo -e "[user]
default = $USER" > /etc/wsl.conf

echo
