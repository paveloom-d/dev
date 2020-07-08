#!/bin/sh

# Print info
echo '\n\e[1;36mInstalling TexLive:\e[0m'

# Update lists of packages
echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

# Install dvipng
echo '\e[1;36m> Installing dvipng...\e[0m'
apt-get install -y --no-install-recommends dvipng >/dev/null

# Install texlive-latex-extra
echo '\e[1;36m> Installing texlive-latex-extra...\e[0m'
apt-get install -y --no-install-recommends texlive-latex-extra >/dev/null

# Install texlive-fonts-extra
echo '\e[1;36m> Installing texlive-fonts-extra...\e[0m'
apt-get install -y --no-install-recommends texlive-fonts-extra >/dev/null

# Install texlive-lang-cyrillic
echo '\e[1;36m> Installing texlive-lang-cyrillic...\e[0m'
apt-get install -y --no-install-recommends texlive-lang-cyrillic >/dev/null

# Install cm-super
echo '\e[1;36m> Installing cm-super...\e[0m'
apt-get install -y --no-install-recommends cm-super >/dev/null

# Clean the apt cache
echo '\e[1;36m> Cleaning the apt cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*