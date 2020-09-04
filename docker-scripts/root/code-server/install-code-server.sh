#!/bin/sh

echo '\n\e[1;36mInstalling `code-server`:\e[0m'

PACKAGE_TAG=3.5.0
PACKAGE_NAME=code-server_${PACKAGE_TAG}_amd64.deb

echo '\e[1;36m> Getting the package...\e[0m'
curl -fOL https://github.com/cdr/code-server/releases/download/v$PACKAGE_TAG/$PACKAGE_NAME >/dev/null 2>&1

echo '\e[1;36m> Installing the package...\e[0m'
dpkg -i $PACKAGE_NAME >/dev/null

echo '\e[1;36m> Deleting the package file...\e[0m'
rm $PACKAGE_NAME