#!/bin/bash

# set the screensize
chmod +x screen.sh
./screen.sh

# main file for running all other setup scripts and grabbing files
apt-get update && apt-get upgrade && apt-get dist-upgrade
apt-get install gobuster git
