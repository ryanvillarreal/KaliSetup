#!/bin/bash

# need to run this straight from github?
# curl https://raw.githubusercontent.com/ryanvillarreal/KaliSetup/master/setup.sh | bash

# main file for running all other setup scripts and grabbing files
apt update -y && apt upgrade -y && apt dist-upgrade -y
apt install gobuster git nodejs npm terminator tmux -y

# setup zsh - probably not safe to do this but meh. 
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Get new tools
cd ~/Downloads/
git clone https://github.com/ryanvillarreal/KaliSetup
cd KaliSetup

# setup golang
cd ~/Downloads/
git clone https://github.com/canha/golang-tools-install-script.git
cd golang-tools-install-script
chmod +x goinstall.sh
./goinstall.sh
source ~/.zshrc
rm -r ~/Downloads/golang-tools-install-script

# Get golang tools
# bettercap needs some extra packages
apt install build-essential libpcap-dev libusb-1.0.0-dev libnetfilter-queue-dev -y 
go get github.com/bettercap/bettercap


#subl requires more work to setup
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update && apt install sublime-text -y


# Ghidra needs Java to run as well as download straight form site
wget https://ghidra-sre.org/ghidra_9.0.4_PUBLIC_20190516.zip -O /opt/ghidra.zip
cd /opt/ && unzip ghidra.zip
apt install default-jdk -y


# update any already exisiting tools
wpscan --update
/etc/init.d/postgresql start
msfdb init


# modify UI things
dconf write /org/gnome/shell/favorite-apps "['firefox.desktop','kali-burpsuite.desktop','terminator.desktop']"


# Move to the download folder for the following tools
cd ~/Downloads/
git clone https://github.com/vpnguy-zz/HandyHeaderHacker.git


