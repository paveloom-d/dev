#!/bin/bash

# This a script which will help you to generate a
# GPG key and connect it to your GitHub account

# Set prompt auxiliary variables
# for ANSI escape codes
red="\e[1;31m"  # Red
mage="\e[1;35m" # Magenta
cyan="\e[1;36m" # Bold cyan
reset="\e[0m"   # Reset colors
bl="\e[1A"      # Back to the beginning of the previous line
cl="\e[K"       # Clear the current line

# Print the header in the prompt
echo -e "\n${cyan}This a script which will help you to generate\n\
a GPG key and connect it to your GitHub account${reset}\n"

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
EMAIL=paveloom@mail.ru
EMAIL_Default=$EMAIL

# Check if the current e-mail is what the user needs
echo -e "${cyan}Current e-mail is set to ${mage}${EMAIL}${cyan}. If it's not the e-mail you expect,"
echo -e "type in the e-mail you want to use. Otherwise, just don't input anything.${reset}\n"
echo -en "${cyan}Your email: ${reset}" && read -r EMAIL
if [ -z "$EMAIL" ]; then
    EMAIL=$EMAIL_Default
    echo -e "${bl}${cl}${cyan}Your email: ${reset}$EMAIL"
fi

# User's name
NAME="Pavel Sobolev"
NAME_Default=$NAME

# Check if the current name is what the user needs
echo -e "\n${cyan}Current name is set to ${mage}${NAME}${cyan}. If it's not your"
echo -e "name, type yours. Otherwise, just don't input anything.${reset}\n"
echo -en "${cyan}Your name: ${reset}" && read -r NAME
if [ -z "$NAME" ]; then
    NAME=$NAME_Default
    echo -e "${bl}${cl}${cyan}Your name: ${reset}$NAME"
fi

# Generate a GPG key
echo -e "\n${cyan}Calling gpg to generate a key. Choose RSA and RSA, 4096 bits long, and enter your credentials.${reset}\n"
gpg --full-generate-key
[ $? -ne 0 ] && echo -e "\n${red}Some error occurred during the call to gpg.${reset}\n" && exit

# Ask to copy the key's ID
gpg --list-secret-keys --keyid-format LONG
echo -e "${cyan}All your GPG keys have been displayed above. Copy an ID of your key\n\
(it's in the row ${mage}sec${cyan}, after the slash) and paste it in the prompt.${reset}\n"
echo -en "${cyan}Your key ID: ${reset}" && read -r KEY

# Print the key
echo && gpg --armor --export $KEY
echo -e "\n${cyan}Copy and paste the output above on GitHub (${mage}Settings -> SSH and GPG keys -> New GPG key${cyan}).${reset}"

# Update the `git` configuration
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global user.signingkey "$KEY"
git config --global push.default matching
git config --global commit.gpgsign true
git config --global gpg.program gpg
echo -e "\n${cyan}This script have also updated the `git` configuration. You can check it using ${mage}git config --list${cyan}.${reset}\n"