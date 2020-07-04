#!/bin/sh

# Print info
echo '\n\e[1m\033[36mInstalling texlive:\033[0m'

# Update lists of packages
echo '\e[1m\033[36m> Updating lists of packages...\033[0m'
apt-get update >/dev/null

# Install dvipng
echo '\e[1m\033[36m> Installing dvipng...\033[0m'
apt-get install -y --no-install-recommends dvipng >/dev/null

# Install texlive-latex-extra
echo '\e[1m\033[36m> Installing texlive-latex-extra...\033[0m'
apt-get install -y --no-install-recommends texlive-latex-extra >/dev/null

# Install texlive-fonts-extra
echo '\e[1m\033[36m> Installing texlive-fonts-extra...\033[0m'
apt-get install -y --no-install-recommends texlive-fonts-extra >/dev/null

# Install texlive-lang-cyrillic
echo '\e[1m\033[36m> Installing texlive-lang-cyrillic...\033[0m'
apt-get install -y --no-install-recommends texlive-lang-cyrillic >/dev/null

# Install cm-super
echo '\e[1m\033[36m> Installing cm-super...\033[0m'
apt-get install -y --no-install-recommends cm-super >/dev/null

# Clean the apt cache
echo '\e[1m\033[36m> Cleaning the apt cache...\033[0m\n'
rm -rf /var/lib/apt/lists/*