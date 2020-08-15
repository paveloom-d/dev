#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling essential packages:\e[0m'

# Update lists of packages
echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

# Install apt-utils
echo '\e[1;36m> Installing apt-utils...\e[0m'
apt-get -y install apt-utils >/dev/null 2>&1

# Install apt-transport-https
echo '\e[1;36m> Installing apt-transport-https...\e[0m'
apt-get install -y --no-install-recommends apt-transport-https >/dev/null

# Install ca-certificates
echo '\e[1;36m> Installing ca-certificates...\e[0m'
apt-get install -y --no-install-recommends ca-certificates >/dev/null

# Install git
echo '\e[1;36m> Installing git...\e[0m'
apt-get install -y --no-install-recommends git >/dev/null

# Install nano
echo '\e[1;36m> Installing nano...\e[0m'
apt-get install -y --no-install-recommends nano >/dev/null

# Install wget
echo '\e[1;36m> Installing wget...\e[0m'
apt-get install -y --no-install-recommends wget >/dev/null

# Install curl
echo '\e[1;36m> Installing curl...\e[0m'
apt-get install -y --no-install-recommends curl >/dev/null

# Install gnupg-agent
echo '\e[1;36m> Installing gnupg-agent...\e[0m'
apt-get install -y --no-install-recommends gnupg-agent >/dev/null

# Install sudo
echo '\e[1;36m> Installing sudo...\e[0m'
wget --no-check-certificate https://github.com/sudo-project/sudo/releases/download/SUDO_1_9_1/sudo_1.9.1-1_ubu2004_amd64.deb >/dev/null 2>&1
apt-get -y install ./sudo_1.9.1-1_ubu2004_amd64.deb >/dev/null
rm sudo_1.9.1-1_ubu2004_amd64.deb

# Install ssh
echo '\e[1;36m> Installing ssh...\e[0m'
apt-get install -y --no-install-recommends ssh >/dev/null

# Install keychain
echo '\e[1;36m> Installing keychain...\e[0m'
apt-get install -y --no-install-recommends keychain >/dev/null

# Install locales
echo '\e[1;36m> Installing locales...\e[0m'
apt-get install -y --no-install-recommends locales >/dev/null
locale-gen ru_RU.UTF-8 >/dev/null

# Install software-properties-common
echo '\e[1;36m> Installing software-properties-common...\e[0m'
apt-get install -y --no-install-recommends software-properties-common >/dev/null

# Clean the apt cache
echo '\e[1;36m> Cleaning the apt cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*