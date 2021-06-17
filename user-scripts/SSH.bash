#!/bin/bash

# This script will help you to generate an
# SSH key and connect it to your GitHub account

set -e
set -o pipefail

# Set prompt auxiliary variables
# for ANSI escape codes
red="\e[1;31m"  # Red
mage="\e[1;35m" # Magenta
cyan="\e[1;36m" # Bold cyan
reset="\e[0m"   # Reset colors
bl="\e[1A"      # Back to the beginning of the previous line
cl="\e[K"       # Clear the current line

# Print the header in the prompt
echo -e "\n${cyan}This script will help you to generate an\n\
SSH key and connect it to your GitHub account${reset}\n"

# Ask if we're good to go
echo -e "${cyan}Continue? (${mage}y${cyan}/${mage}n${cyan})${reset}\n"
while true; do
    read -s -n1 answer
    case $answer in
        [Yy]* ) break;;
        [Nn]* ) echo -e "${red}The script has been interrupted.${reset}\n"; exit;;
        * ) echo -e "${cyan}Please, answer ${mage}y${cyan} or ${mage}n${cyan}.${reset}\n";;
    esac
done

# User's e-mail
EMAIL=paveloom@tuta.io
EMAIL_Default=$EMAIL

# Check if the current e-mail is what the user needs
echo -e "${cyan}Current e-mail is set to ${mage}${EMAIL}${cyan}. If it's not the e-mail you expect,"
echo -e "type in the e-mail you want to use. Otherwise, just don't input anything.${reset}\n"
echo -en "${cyan}Your email: ${reset}" && read -r EMAIL
if [ -z "$EMAIL" ]; then
    EMAIL=$EMAIL_Default
    echo -e "${bl}${cl}${cyan}Your email: ${reset}$EMAIL"
fi

# Generate an SSH key
echo -e "\n${cyan}Calling ssh-keygen to generate an SSH key. Follow the instructions.${reset}\n"
ssh-keygen -t rsa -b 4096 -C "$EMAIL"
[ $? -ne 0 ] && echo -e "\n${red}Some error occurred during the call to ssh-keygen.${reset}\n" && exit

# Start an `ssh-agent` in the background (just in case it's not up already)
eval "$(ssh-agent -s)" > /dev/null 2>&1

# Echo the contents of the public key
echo -e "\n${cyan}Specify the path to the key, or leave it blank to use the default path: ${mage}~/.ssh/id_rsa${cyan}.${reset}\n"
echo -en "${cyan}Path to your key: ${reset}" && read -r KEY
if [ -z "$KEY" ]; then
    KEY=~/.ssh/id_rsa
    echo -e "${bl}${cl}${cyan}Path to your key: ${reset}$KEY"
fi
echo && cat "$KEY.pub"
echo -e "\n${cyan}This is the public part of your key. Copy and paste it on GitHub (${mage}Settings -> SSH and GPG keys -> New SSH key${cyan}).${reset}"

# Print final words
echo -e "\n${cyan}And that's it.${reset}\n"
