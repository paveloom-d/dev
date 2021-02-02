#!/bin/sh

echo '\n\e[1;36mPointing to the hosts file for SSH:\e[0m'

echo '\e[1;36m> Creating `~/.ssh/config`...\e[0m\n'
mkdir -p ~/.ssh
echo 'UserKnownHostsFile ~/.ssh/known_hosts' > ~/.ssh/config
