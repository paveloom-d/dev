#!/bin/bash

echo '\n\e[1;36mInstalling the browser:\e[0m'

echo '\e[1;36m> Updating lists of packages...\e[0m'
apt-get update >/dev/null

echo '\e[1;36m> Installing Midori...\e[0m'
apt-get install -y --no-install-recommends midori >/dev/null

echo '\e[1;36m> Cleaning the `apt` cache...\e[0m\n'
rm -rf /var/lib/apt/lists/*
