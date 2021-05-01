#!/bin/bash

echo -e '\n\e[1;36mInstalling essential packages:\e[0m'

echo -e '\e[1;36m> Installing `apt-utils`...\e[0m'
install_packages apt-utils >/dev/null 2>&1

echo -e '\e[1;36m> Installing `htop`...\e[0m'
install_packages htop >/dev/null

echo -e '\e[1;36m> Installing `ca-certificates`...\e[0m'
install_packages ca-certificates >/dev/null

# echo -e '\e[1;36m> Installing `git`...\e[0m'
# install_packages git >/dev/null

echo -e '\e[1;36m> Installing `ncdu`...\e[0m'
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

echo -e '\e[1;36m> Installing `gpg` and `gnupg-agent`...\e[0m'
install_packages gpg gnupg-agent >/dev/null

echo -e '\e[1;36m> Installing `sudo`...\e[0m'
install_packages sudo >/dev/null

echo -e '\e[1;36m> Installing `ssh`...\e[0m'
install_packages ssh >/dev/null

echo -e '\e[1;36m> Installing `keychain`...\e[0m'
install_packages keychain >/dev/null

echo -e '\e[1;36m> Installing `locales`...\e[0m'
install_packages locales >/dev/null

echo
