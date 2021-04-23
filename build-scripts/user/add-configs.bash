#!/bin/bash

echo -e '\n\e[1;36mAdding configs:\e[0m'

echo -e '\e[1;36m> Creating `~/.ssh/config`...\e[0m'
mkdir -p ~/.ssh
echo -e 'UserKnownHostsFile ~/.ssh/known_hosts' > ~/.ssh/config

echo -e '\e[1;36m> Creating `/etc/wsl.conf`...\e[0m'
sudo bash -c "echo -e '[user]
default = ${USER}' > /etc/wsl.conf"

echo
