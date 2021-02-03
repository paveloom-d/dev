#!/bin/bash

echo -e '\n\e[1;36mInstalling Podman and Buildah:\e[0m'

echo -e '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

echo -e '\e[1;36m> Installing Podman...\e[0m'
apt-get install -y --no-install-recommends podman >/dev/null

echo -e '\e[1;36m> Installing Buildah...\e[0m'
apt-get install -y --no-install-recommends buildah >/dev/null

echo -e '\e[1;36m> Cleaning the `apt` cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*
