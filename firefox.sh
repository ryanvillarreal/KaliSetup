#!/bin/bash

# Purge the old firefox
apt-get purge firefox
apt-get autoclean
unlink /usr/bin/firefox
mv /usr/bin/firefox /tmp/firefox_bak

# get rid of firefox-esr too
unlink /usr/bin/firefox-esr
mv /usr/bin/firefox-esr /tmp/firefox-esr

# Get the new firefox and link everything up
cd /usr/local
wget "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" -O firefox-latest.tar.bz2
tar xvjf firefox-latest.tar.bz2
rm firefox-latest.tar.bz2
ln -s /usr/local/firefox/firefox /usr/bin/firefox
rm /usr/share/applications/firefox-esr.desktop

# Now add the item to the favorites bar and the menu
echo "[Desktop Entry]
Version=latest
Name=Firefox
Comment=The latest Mozilla Firefox Browser
Exec=/usr/bin/firefox
Icon=/usr/local/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Utility;Application;" > /usr/share/applications/firefox.desktop

# Should be finished/ launch firefox
firefox &
