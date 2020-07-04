#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling Julia:\033[0m'

# Download the tarball
echo '\e[1m\033[36m> Downloading the tarball...\033[0m'
wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.2-linux-x86_64.tar.gz -P ~/Other/julia >/dev/null 2>&1

# Extract the tarball
echo '\e[1m\033[36m> Extracting the tarball...\033[0m'
tar -xf ~/Other/julia/julia*.tar.gz -C ~/Other/julia --strip-components 1

# Delete the tarball
echo '\e[1m\033[36m> Deleting the tarball...\033[0m'
rm ~/Other/julia/julia*.tar.gz

# Install Revise
echo '\e[1m\033[36m> Installing Revise...\033[0m'
julia -e 'using Pkg; Pkg.add("Revise"); using Revise' >/dev/null 2>&1

# Install IJulia
echo '\e[1m\033[36m> Installing IJulia...\033[0m'
julia -e 'using Pkg; Pkg.add("IJulia"); using IJulia' >/dev/null 2>&1

# Install PyPlot
echo '\e[1m\033[36m> Installing PyPlot...\033[0m'
julia -e 'using Pkg; Pkg.add("PyPlot"); using PyPlot' >/dev/null 2>&1

# Install Plots
echo '\e[1m\033[36m> Installing Plots...\033[0m\n'
julia -e 'using Pkg; Pkg.add("Plots"); using Plots' >/dev/null 2>&1