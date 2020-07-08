#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling docker:\e[0m'

# Update lists of packages
echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

# Add docker's official GPG key
echo "\e[1;36m> Addding docker's official GPG key...\e[0m"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - >/dev/null

# Set up stable repository
echo '\e[1;36m> Setting up stable repository...\e[0m'
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >/dev/null

# Install Docker engine
echo '\e[1;36m> Installing Docker engine...\e[0m'
apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io >/dev/null

# Add the user to the docker group
echo '\e[1;36m> Adding the user to the docker group...\e[0m'
usermod -aG docker $USER

# Clean the apt cache
echo '\e[1;36m> Cleaning the apt cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*