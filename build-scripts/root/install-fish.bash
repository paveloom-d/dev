#!/bin/bash

echo -e '\n\e[1;36mInstalling Fish:\e[0m'

echo -e '\e[1;36m> Installing the package...\e[0m'
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
install_packages fish >/dev/null

echo -e '\e[1;36m> Changing the default shell...\e[0m'
sed -i -e "s/bin\/ash/usr\/bin\/fish/" /etc/passwd

echo
