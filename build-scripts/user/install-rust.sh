#!/bin/sh

echo '\n\e[1;36mInstalling Rust:\e[0m'

echo '\e[1;36m> Installing `rustup`...\e[0m'
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y #&>/dev/null

echo '\e[1;36m> Explicitly updating the PATH variable in the `~/.zshrc`...\e[0m\n'
echo '
# Add Rust binaries to the `PATH`
export PATH=$PATH:/home/$USER/.cargo/bin' >> ~/.zshrc

~/.cargo/bin/rustc --version
