#!/bin/bash

# A script to build the image and test a container based on it

# Download dive
printf "\nDownloading dive...\n\n"
wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb

# Install dive
printf "Installing dive...\n\n"
sudo apt install ./dive_0.9.2_linux_amd64.deb

# Activate experimental features
printf "\nActivating experimental features...\n"
sudo tee /etc/docker/daemon.json > /dev/null << EOF
{
    "experimental": true
}
EOF
sudo service docker restart

# Build the image
printf "\nBuilding the image...\n\n"
docker build -t image --squash .

# Analyse the image
printf "\nAnalyzing the image...\n\n"
CI=true dive image

# Delete unnecessary build images
printf "Building the image...\n\n"
docker images -q | grep -E -v "$(docker images -q 'image')|$(docker images -q 'alpine')" | xargs docker rmi

# Run a container
printf "\nRunning a container...\n\n"
docker run --name container -d -t image

# Test if Zsh is installed
printf "\nTesting if Zsh is installed...\n\n"
docker exec container zsh --version

# Stop the container
printf "\nStopping the container...\n\n"
docker stop container