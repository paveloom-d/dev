#!/bin/bash

# This script will install the latest stable version of Julia

set -e
set -o pipefail

echo -e '\n\e[1;36mInstalling Julia:\e[0m'

JULIA_VERSION=$(curl --silent "https://api.github.com/repos/julialang/julia/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v(.+)".*/\1/')
JULIA_SERIES=$(echo ${JULIA_VERSION} | sed -E 's/\.[0-9]+$//')

echo -e '\e[1;36m> Downloading the tarball...\e[0m'
wget "https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_SERIES}/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" -P ~/Other/julia >/dev/null 2>&1

echo -e '\e[1;36m> Extracting the tarball...\e[0m'
tar -xf ~/Other/julia/julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C ~/Other/julia --strip-components 1

echo -e '\e[1;36m> Deleting the tarball...\e[0m'
rm ~/Other/julia/julia*.tar.gz

echo -e '\e[1;36m> Explicitly updating the PATH variable in the `~/.zshrc`...\e[0m'
echo '
# Add Julia binary to the `PATH`
export PATH=$PATH:/home/$USER/Other/julia/bin' >> ~/.zshrc

echo
