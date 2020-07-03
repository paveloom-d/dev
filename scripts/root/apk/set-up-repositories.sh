#!/bin/sh

# Print info
echo -e '\n\e[1m\033[36mSetting up repositories:\033[0m'

# Add a repository for the v3.10 branch
echo -e '\e[1m\033[36mAdding a repository for the v3.10 branch...\033[0m'
echo '@v3.10 http://dl-cdn.alpinelinux.org/alpine/v3.10/main' >> /etc/apk/repositories

# Update lists of the packages
echo -e '\e[1m\033[36mUpdating lists of the packages...\033[0m\n'
apk --no-cache update >/dev/null