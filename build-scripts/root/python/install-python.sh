#!/bin/sh

echo '\n\e[1;36mInstalling Python:\e[0m'

echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

echo '\e[1;36m> Installing `python3-dev`...\e[0m'
apt-get install -y --no-install-recommends python3-dev >/dev/null

echo '\e[1;36m> Installing `python3-pip`...\e[0m'
apt-get install -y --no-install-recommends python3-pip >/dev/null

echo '\e[1;36m> Cleaning the `apt` cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*
