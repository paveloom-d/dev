#!/bin/bash

# A script to build the image and test a container based on it

# Download dive
wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb

# Install dive
sudo apt install ./dive_0.9.2_linux_amd64.deb

# Build the image
CI=true dive build -t image --squash .

# Delete unnecessary build images
docker images -q | grep -E -v "$(docker images -q 'image')|$(docker images -q 'alpine')" | xargs docker rmi

# Run a container
docker run --name container -d -t image

# Test if Zsh is installed
docker exec container zsh --version

# Stop the container
docker stop container