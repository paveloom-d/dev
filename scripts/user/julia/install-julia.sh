#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mInstalling Julia:\033[0m'

# Download the tarball
echo -e '\e[1m\033[36m> Downloading the tarball...\033[0m'
[ ! -d "~/Other/julia" ] && mkdir -p ~/Other/julia
wget https://julialang-s3.julialang.org/bin/musl/x64/1.5/julia-1.5.0-rc1-musl-x86_64.tar.gz -P ~/Other/julia >/dev/null 2>&1

# Extract the tarball
echo -e '\e[1m\033[36m> Extracting the tarball...\033[0m'
tar -xf ~/Other/julia/julia*.tar.gz -C ~/Other/julia --strip-components 1

# Delete the tarball
echo -e '\e[1m\033[36m> Deleting the tarball...\033[0m'
rm ~/Other/julia/julia*.tar.gz

# Install Revise.jl
echo -e '\e[1m\033[36m> Installing Revise.jl...\033[0m\n'
julia -e 'using Pkg; Pkg.add("Revise"); using Revise' >/dev/null 2>&1