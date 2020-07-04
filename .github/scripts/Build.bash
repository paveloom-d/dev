#!/bin/bash

# A script to build the image and test a container based on it

# Check for the branch (this is a fallback for the situation when
# Travis triggers a build for a base commit of a newly created branch,
# basically building the same image again, which is not necessary)

echo -e "\n\e[1m\033[36mCurrent branch: $TRAVIS_BRANCH\033[0m\n"

if [ "$TRAVIS_BRANCH" != "master" ]; then

    # Download dive
    echo -e '\e[1m\033[36mDownloading dive...\033[0m\n'
    wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb

    # Install dive
    echo -e '\e[1m\033[36mInstalling dive...\033[0m\n'
    sudo apt install ./dive_0.9.2_linux_amd64.deb

    # Activate experimental features
    echo -e '\n\e[1m\033[36mActivating experimental features...\033[0m\n'
    sudo tee /etc/docker/daemon.json > /dev/null << EOF
{
    "experimental": true
}
EOF
    sudo service docker restart

    # Build the image
    echo -e '\e[1m\033[36mBuilding the image...\033[0m\n'
    docker build -t image --squash .

    # Analyse the image
    echo -e '\n\e[1m\033[36mAnalyzing the image...\033[0m\n'
    CI=true dive image

else

    # Print info
    echo -e '\e[1m\033[36mThis build was probably triggered by creating a new\033[0m'
    echo -e '\e[1m\033[36mbranch, so there is no need to rebuild the image.\033[0m\n'

fi