#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling essential packages:\033[0m'

# Update lists of packages
echo '\e[1m\033[36m> Updating lists of packages...\033[0m'
apt-get update >/dev/null

# Install apt-utils
echo '\e[1m\033[36m> Installing apt-utils...\033[0m'
apt-get -y install apt-utils >/dev/null 2>&1

# Install apt-transport-https
echo '\e[1m\033[36m> Installing apt-transport-https...\033[0m'
apt-get install -y --no-install-recommends apt-transport-https >/dev/null

# Install ca-certificates
echo '\e[1m\033[36m> Installing ca-certificates...\033[0m'
apt-get install -y --no-install-recommends ca-certificates >/dev/null

# Install git
echo '\e[1m\033[36m> Installing git...\033[0m'
apt-get install -y --no-install-recommends git >/dev/null

# Install nano
echo '\e[1m\033[36m> Installing nano...\033[0m'
apt-get install -y --no-install-recommends nano >/dev/null

# Install wget
echo '\e[1m\033[36m> Installing wget...\033[0m'
apt-get install -y --no-install-recommends wget >/dev/null

# Install curl
echo '\e[1m\033[36m> Installing curl...\033[0m'
apt-get install -y --no-install-recommends curl >/dev/null

# Install gnupg-agent
echo '\e[1m\033[36m> Installing gnupg-agent...\033[0m'
apt-get install -y --no-install-recommends gnupg-agent >/dev/null

# Install sudo
echo '\e[1m\033[36m> Installing sudo...\033[0m'
wget --no-check-certificate https://github.com/sudo-project/sudo/releases/download/SUDO_1_9_1/sudo_1.9.1-1_ubu2004_amd64.deb >/dev/null 2>&1
apt-get -y install ./sudo_1.9.1-1_ubu2004_amd64.deb >/dev/null
rm sudo_1.9.1-1_ubu2004_amd64.deb

# Install openssh-client
echo '\e[1m\033[36m> Installing openssh-client...\033[0m'
apt-get install -y --no-install-recommends openssh-client >/dev/null

# Install software-properties-common
echo '\e[1m\033[36m> Installing software-properties-common...\033[0m'
apt-get install -y --no-install-recommends software-properties-common >/dev/null

# Clean the apt cache
echo '\e[1m\033[36m> Cleaning the apt cache...\033[0m\n'
rm -rf /var/lib/apt/lists/*