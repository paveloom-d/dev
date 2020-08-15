#!/bin/sh

echo '\n\e[1;36mInstalling Docker:\e[0m'

echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

echo "\e[1;36m> Addding Docker's official GPG key...\e[0m"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - >/dev/null

echo '\e[1;36m> Setting up the stable repository...\e[0m'
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >/dev/null

echo '\e[1;36m> Installing Docker engine...\e[0m'
apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io >/dev/null

echo '\e[1;36m> Adding the user to the `docker` group...\e[0m'
usermod -aG docker $USER

echo '\e[1;36m> Cleaning the `apt` cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*