#!/bin/bash

# main file for running all other setup scripts and grabbing files
apt-get update && apt-get upgrade && apt-get dist-upgrade
apt-get install gobuster git 
git clone https://github.com/XjCrazy09/KaliSetup
cd KaliSetup

# set the screensize
chmod +x screen.sh
./screen.sh

# move to the download folder for the following tools
cd ~/Downloads/
git clone https://github.com/danielmiessler/SecLists
