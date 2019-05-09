#! /bin/bash

# Cronjob to make sure the OpenVPN service is running.  
# Check to make sure the device can ping a gateway or the Internet before restarting the service. 

LOGFILE=/var/log/openvpn/serviceCheck.log

# check the service first.
if [ "`systemctl is-active openvpn`" != "active" ]
then
	echo "[`date '+%Y:%m:%d %H:%M:%S'`] Service wasn't running so attempting to restart" >> $LOGFILE 2>&1
	systemctl start openvpn
	exit 0
fi
echo "[`date '+%Y:%m:%d %H:%M:%S'`] OpenVPN is already running" >> $LOGFILE 2>&1


# check to make sure the tunnel exists
if /sbin/ethtool tun0 | grep -q "Link detected: yes"; then
	echo "[`date '+%Y:%m:%d %H:%M:%S'`] Tunnel exists." >> $LOGFILE 2>&1
else
	echo "[`date '+%Y:%m:%d %H:%M:%S'`] OpenVPN is running, but tunnel does not exist. Restarting service." >> $LOGFILE 2>&1
	systemctl restart openvpn
fi
