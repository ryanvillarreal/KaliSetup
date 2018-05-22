#!/bin/bash

#
# Script to automate the setup of Docker/DNSmasq/nginx-reverse-proxy/Vulnerable Web Apps
#

# Install Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb https://download.docker.com/linux/debian stretch stable' > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get remove docker docker-engine docker.io -y 
apt-get install docker-ce -y 
systemctl start docker
systemctl enable docker

# Install Dnsmasq
apt-get install dnsmasq -y 
echo "# New Changes
listen-address=127.0.0.1
bind-interfaces
address=/.local/127.0.0.1" >> /etc/dnsmasq.conf
systemctl enable dnsmasq

# Docker Pull down
docker pull jwilder/nginx-proxy:latest
docker pull bkimminich/juice-shop
docker pull citizenstig/nowasp
docker pull citizenstig/dvwa

# Docker Config
docker network create vuln
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro --name rev_proxy --net vuln --restart always jwilder/nginx-proxy
docker run -d -e VIRTUAL_HOST=juice.local --net vuln --restart always bkimminich/juice-shop
docker run -d -e VIRTUAL_HOST=mutillidae.local --net vuln --restart always citizenstig/nowasp
docker run -d -e VIRTUAL_HOST=dvwa.local --net vuln --restart always citizenstig/dvwa

# If you can figure out how to get the system to accept dnsmasq changes without reboot please let me know
reboot
