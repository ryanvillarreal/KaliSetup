#!/bin/bash

# need to run this straight from github?  
# curl https://raw.githubusercontent.com/ryanvillarreal/KaliSetup/master/setup.sh | bash

# main file for running all other setup scripts and grabbing files
apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y
apt-get install gobuster git nodejs npm -y
cd ~/Downloads/
git clone https://github.com/XjCrazy09/KaliSetup
cd KaliSetup
pwd

# update any already exisiting tools
wpscan --update
cd ~/Downloads/KaliSetup/
chmod + x ./firefox.sh
./firefox.sh
pwd

dconf write /org/gnome/shell/favorite-apps "['firefox.desktop','kali-burpsuite.desktop','org.gnome.Terminal.desktop']"


# Move to the download folder for the following tools
cd ~/Downloads/
git clone https://github.com/danielmiessler/SecLists
git clone https://github.com/ShawnDEvans/smbmap.git
apt-get install terminator -y
git clone https://github.com/jshaw87/Cheatsheets.git
git clone https://github.com/SherifEldeeb/TinyMet.git
git clone https://github.com/RUB-NDS/PRET.git
git clone https://github.com/stampery/mongoaudit.git
git clone https://github.com/Gallopsled/pwntools.git
git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester.git
git clone https://github.com/cortesi/mitmproxy.git
git clone https://github.com/BloodHoundAD/BloodHound.git
git clone https://github.com/EmpireProject/Empire.git
git clone https://github.com/guelfoweb/knock.git
pwd
