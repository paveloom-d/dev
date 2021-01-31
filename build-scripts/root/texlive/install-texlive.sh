#!/bin/sh

echo '\n\e[1;36mInstalling TexLive:\e[0m'

echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

echo '\e[1;36m> Installing `dvipng`...\e[0m'
apt-get install -y --no-install-recommends dvipng >/dev/null

echo '\e[1;36m> Installing `texlive-latex-extra`...\e[0m'
apt-get install -y --no-install-recommends texlive-latex-extra >/dev/null

echo '\e[1;36m> Installing `texlive-fonts-extra`...\e[0m'
apt-get install -y --no-install-recommends texlive-fonts-extra >/dev/null

echo '\e[1;36m> Installing `texlive-lang-cyrillic`...\e[0m'
apt-get install -y --no-install-recommends texlive-lang-cyrillic >/dev/null

echo '\e[1;36m> Installing `cm-super`...\e[0m'
apt-get install -y --no-install-recommends cm-super >/dev/null

echo '\e[1;36m> Cleaning the `apt` cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*