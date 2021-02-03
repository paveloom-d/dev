#!/bin/bash

echo -e '\n\e[1;36mInstalling X2Go Server and XFCE:\e[0m'

echo -e '\e[1;36m> Adding a repository...\e[0m'
add-apt-repository -y ppa:x2go/stable >/dev/null

echo -e '\e[1;36m> Installing the server...\e[0m'
apt-get install -y --no-install-recommends x2goserver x2goserver-xsession >/dev/null

echo -e '\e[1;36m> Installing XFCE...\e[0m\n'
apt-get install -y --no-install-recommends xfce4 xfce4-terminal >/dev/null
