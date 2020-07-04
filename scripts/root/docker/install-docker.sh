#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling docker:\033[0m'

# Update lists of packages
echo '\e[1m\033[36m> Updating lists of packages...\033[0m'
apt-get update >/dev/null

# Add docker's official GPG key
echo "\e[1m\033[36m> Addding docker's official GPG key...\033[0m"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - >/dev/null

# Set up stable repository
echo '\e[1m\033[36m> Setting up stable repository...\033[0m'
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >/dev/null

# Install Docker engine
echo '\e[1m\033[36m> Installing Docker engine...\033[0m'
apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io >/dev/null

# Add the user to the docker group
echo '\e[1m\033[36m> Adding the user to the docker group...\033[0m'
usermod -aG docker $USER

# Clean the apt cache
echo '\e[1m\033[36m> Cleaning the apt cache...\033[0m\n'
rm -rf /var/lib/apt/lists/*