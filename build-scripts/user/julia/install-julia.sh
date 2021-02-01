#!/bin/sh

echo '\n\e[1;36mInstalling Julia:\e[0m'

echo '\e[1;36m> Downloading the tarball...\e[0m'
wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.3-linux-x86_64.tar.gz -P ~/Other/julia >/dev/null 2>&1

echo '\e[1;36m> Extracting the tarball...\e[0m'
tar -xf ~/Other/julia/julia*.tar.gz -C ~/Other/julia --strip-components 1

echo '\e[1;36m> Deleting the tarball...\e[0m'
rm ~/Other/julia/julia*.tar.gz

echo '
# Add Julia to the PATH
export PATH=$PATH:/home/$USER/Other/julia/bin' >> ~/.zshrc

echo '\e[1;36m> Installing `Documenter`...\e[0m'
julia -e 'using Pkg; Pkg.add("Documenter"); using Documenter' >/dev/null 2>&1

echo '\e[1;36m> Installing `Literate`...\e[0m'
julia -e 'using Pkg; Pkg.add("Literate"); using Literate' >/dev/null 2>&1

echo '\e[1;36m> Installing `Revise`...\e[0m'
julia -e 'using Pkg; Pkg.add("Revise"); using Revise' >/dev/null 2>&1

echo '\e[1;36m> Installing `IJulia`...\e[0m'
julia -e 'using Pkg; Pkg.add("IJulia"); using IJulia' >/dev/null 2>&1

echo '\e[1;36m> Installing `PyPlot`...\e[0m'
julia -e 'using Pkg; Pkg.add("PyPlot"); using PyPlot' >/dev/null 2>&1

echo '\e[1;36m> Installing `Plots`...\e[0m\n'
julia -e 'using Pkg; Pkg.add("Plots"); using Plots' >/dev/null 2>&1
