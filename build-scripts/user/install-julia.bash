#!/bin/bash

echo -e '\n\e[1;36mInstalling Julia:\e[0m'

echo -e '\e[1;36m> Downloading the tarball...\e[0m'
wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.0-linux-x86_64.tar.gz -P ~/Other/julia >/dev/null 2>&1

echo -e '\e[1;36m> Extracting the tarball...\e[0m'
tar -xf ~/Other/julia/julia*.tar.gz -C ~/Other/julia --strip-components 1

echo -e '\e[1;36m> Deleting the tarball...\e[0m'
rm ~/Other/julia/julia*.tar.gz

echo -e '\e[1;36m> Explicitly updating the PATH variable in the `~/.zshrc`...\e[0m'
echo '
# Add Julia binaries to the `PATH`
export PATH=$PATH:/home/$USER/Other/julia/bin' >> ~/.zshrc

echo
