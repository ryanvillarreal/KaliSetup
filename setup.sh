#!/bin/bash

# need to run this straight from github?
# curl https://raw.githubusercontent.com/ryanvillarreal/KaliSetup/master/setup.sh | bash

# main file for running all other setup scripts and grabbing files
apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y
apt-get install gobuster git nodejs npm terminator -y
cd ~/Downloads/
git clone https://github.com/ryanvillarreal/KaliSetup
cd KaliSetup

# update any already exisiting tools
wpscan --update
/etc/init.d/postgresql start
msfdb init
cd ~/Downloads/KaliSetup/
chmod +x ./firefox.sh
./firefox.sh

dconf write /org/gnome/shell/favorite-apps "['firefox.desktop','kali-burpsuite.desktop','terminator.desktop']"
cd ~/Downloads/KaliSetup/
python linux-lumberjack.py
su root

# install aptitude tools
apt install tmux -y

# Move to the download folder for the following tools
cd ~/Downloads/
#git clone https://github.com/danielmiessler/SecLists #uncomment if you are okay with a big download
git clone https://github.com/ShawnDEvans/smbmap.git
git clone https://github.com/jshaw87/Cheatsheets.git
git clone https://github.com/SherifEldeeb/TinyMet.git
git clone https://github.com/RUB-NDS/PRET.git
git clone https://github.com/stampery/mongoaudit.git
git clone https://github.com/Gallopsled/pwntools.git
git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester.git
git clone https://github.com/cortesi/mitmproxy.git
git clone https://github.com/BloodHoundAD/BloodHound.git
git clone https://github.com/EmpireProject/Empire.git
curl -kL https://github.com/tizonia/tizonia-openmax-il/raw/master/tools/install.sh | bash
