#!/bin/bash

echo -e '\n\e[1;36mPointing to the hosts file for SSH:\e[0m'

echo -e '\e[1;36m> Creating `~/.ssh/config`...\e[0m\n'
mkdir -p ~/.ssh
echo -e 'UserKnownHostsFile ~/.ssh/known_hosts' > ~/.ssh/config
