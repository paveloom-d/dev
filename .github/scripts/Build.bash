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

    # Delete redundant build images
    echo -e '\e[1m\033[36mDeleting redundant build images...\033[0m\n'
    docker images -q | grep -E -v "$(docker images -q 'image')|$(docker images -q 'alpine')" | xargs docker rmi

    # Run a container
    echo -e '\n\e[1m\033[36mRunning a container...\033[0m\n'
    docker run --name container -v /var/run/docker.sock:/var/run/docker.sock -d -t image

    # Test if Zsh is installed
    echo -e '\n\e[1m\033[36mTesting if Zsh is installed...\033[0m\n'
    docker exec container zsh --version

    # Open a docker socket for others group
    echo -e '\n\e[1m\033[36mOpening a docker socket for others group...\033[0m\n'
    sudo chmod o+rw /var/run/docker.sock

    # Test if docker is installed (also check permissions)
    echo -e '\e[1m\033[36mTesting if docker is installed...\033[0m\n'
    docker exec container docker version

    # Run hello-world in docker (also check permissions)
    echo -e '\n\e[1m\033[36mRunning hello-world in docker...\033[0m\n'
    docker exec container docker run hello-world

    # Check if Jupyter is installed
    echo -e '\e[1m\033[36mChecking if Jupyter is installed...\033[0m\n'
    docker exec container jupyter --version

    # Check if Jupyter is installed
    echo -e '\e[1m\033[36mChecking if Julia is installed...\033[0m\n'
    docker exec container julia --version

    # Stop the container
    echo -e '\n\e[1m\033[36mStopping the container...\033[0m\n'
    docker stop container

else

    # Print info
    echo -e '\e[1m\033[36mThis build was probably triggered by creating a new\033[0m'
    echo -e '\e[1m\033[36mbranch, so there is no need to rebuild the image.\033[0m\n'

fi