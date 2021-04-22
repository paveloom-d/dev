#!/bin/bash

echo -e '\n\e[1;36mInstalling essential packages:\e[0m'

# echo -e '\e[1;36m> Updating lists of packages...\e[0m'
# apt-get update >/dev/null

# echo -e '\e[1;36m> Installing `apt-utils`...\e[0m'
# apt-get -y install apt-utils >/dev/null 2>&1

# echo -e '\e[1;36m> Installing `apt-transport-https`...\e[0m'
# apt-get install -y --no-install-recommends apt-transport-https >/dev/null

# echo -e '\e[1;36m> Installing `build-essential`...\e[0m'
# apt-get install -y --no-install-recommends build-essential >/dev/null

# echo -e '\e[1;36m> Installing `dialog`...\e[0m'
# apt-get install -y --no-install-recommends dialog >/dev/null

# echo -e '\e[1;36m> Installing `dumb-init`...\e[0m'
# apt-get install -y --no-install-recommends dumb-init >/dev/null

echo -e '\e[1;36m> Installing `htop`...\e[0m'
# apt-get install -y --no-install-recommends htop >/dev/null
install_packages htop

# echo -e '\e[1;36m> Installing `ca-certificates`...\e[0m'
# apt-get install -y --no-install-recommends ca-certificates >/dev/null

echo -e '\e[1;36m> Installing `git`...\e[0m'
install_packages git >/dev/null

# echo -e '\e[1;36m> Installing `make`...\e[0m'
# apt-get install -y --no-install-recommends make >/dev/null

# echo -e '\e[1;36m> Installing `screen`...\e[0m'
# apt-get install -y --no-install-recommends screen >/dev/null

echo -e '\e[1;36m> Installing `ncdu`...\e[0m'
# apt-get install -y --no-install-recommends ncdu >/dev/null
install_packages ncdu >/dev/null

echo -e '\e[1;36m> Installing `zip` and `unzip`...\e[0m'
install_packages zip unzip >/dev/null

echo -e '\e[1;36m> Installing `nano`...\e[0m'
install_packages nano >/dev/null

echo -e '\e[1;36m> Installing `less`...\e[0m'
install_packages less >/dev/null

echo -e '\e[1;36m> Installing `wget`...\e[0m'
install_packages wget >/dev/null

echo -e '\e[1;36m> Installing `curl`...\e[0m'
install_packages curl >/dev/null

echo -e '\e[1;36m> Installing `gnupg-agent`...\e[0m'
install_packages gnupg-agent >/dev/null

echo -e '\e[1;36m> Installing `sudo`...\e[0m'
# wget --no-check-certificate https://github.com/sudo-project/sudo/releases/download/SUDO_1_9_6p1/sudo_1.9.6-2_deb10_amd64.deb >/dev/null 2>&1
# apt-get -y install ./sudo_1.9.1-1_ubu2004_amd64.deb >/dev/null
# rm sudo_1.9.1-1_ubu2004_amd64.deb
install_packages sudo >/dev/null

echo -e '\e[1;36m> Installing `ssh`...\e[0m'
install_packages ssh >/dev/null

echo -e '\e[1;36m> Installing `keychain`...\e[0m'
install_packages keychain >/dev/null

echo -e '\e[1;36m> Installing `locales`...\e[0m'
install_packages locales >/dev/null
locale-gen ru_RU.UTF-8 >/dev/null

# echo -e '\e[1;36m> Installing `language-pack-en-base`...\e[0m'
# apt-get install -y --no-install-recommends language-pack-en-base >/dev/null
# install_packages language-pack-en-base

# echo -e '\e[1;36m> Installing `software-properties-common`...\e[0m'
# apt-get install -y --no-install-recommends software-properties-common >/dev/null

# echo -e '\e[1;36m> Cleaning the `apt` cache...\e[0m\n'
# rm -rf /var/lib/apt/lists/*
