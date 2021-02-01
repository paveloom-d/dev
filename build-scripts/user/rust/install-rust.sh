#!/bin/sh

echo '\n\e[1;36mInstalling Rust:\e[0m'

echo '\e[1;36m> Installing `rustup`...\e[0m\n'
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

rustc --version
