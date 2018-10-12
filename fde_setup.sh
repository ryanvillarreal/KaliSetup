#!/bin/bash

openvpn_setup(){
	# function used to setup the OpenVPN tunnel
	echo "openvpn setup. "
}

health_check_setup(){
	# function used to setup the cronjob that will do health checking on the OpenVPN tunnel.  
	echo "cronjob setup."
}

colors(){
	# function used to add a little color to the output.  
	echo "use colors."
}


list_devices(){
	echo ""
	echo ":: Showing available disks - make sure /dev/sdb is the destination USB device."
	sleep 1
	sudo fdisk -l | grep /dev/

	echo ""
	echo "=========="
	echo "# Please enter the destination disk you wish to image."
	echo "# An example input is: sda"
	echo "!!! WARNING - Make sure you are selecting the correct disk. Failing to do so will write over the Imaging USB."
	echo -n "> "
	read inputDisk
	confirm_drive
}

confirm_drive(){
	echo "Are you sure you want to use /dev/$inputDisk [yes/no]"
	echo -n "> "
	read inputEnd
	if [[ $inputEnd == *"y"* ]]; then
		setup_usb
	fi
	if [[ $inputEnd == *"n"* ]]; then
		list_devices
	fi
}

setup_usb(){
	tmpDrive=$inputDisk"1"
	# make sure the USB isn't mounted yet, check to see and if so remove it.
	umount /dev/$tmpDrive
	statusCode=$?
	if [[ $(umount /dev/$tmpDrive) -eq 0 ]]; then
		echo "Succesfully umounted drive"
	else
		echo "Drive not umounted, advised not to continue"
	fi

	# Create keyfile and add it to the Luks
	dd if=/dev/urandom of=keyfile bs=512 count=4
	if [ ! -f keyfile ]; then
    	echo "File not found!"
    else
    	# if file was setup correctly add it to the cryptsetup
		cryptsetup luksAddKey /dev/sda5 keyfile
	fi

	# Setup the usbdrive
	mkfs -F -t ext2 /dev/$tmpDrive
	e2label /dev/$tmpDrive KEYS

	#if statement to check the file format and the label.  
	if [[ $(blkid -o value --match-tag TYPE /dev/$tmpDrive) -eq "ext2" ]]; then
		echo "File Format: success"
	else
		echo "File format not correct. "
	fi

	#if statement to check label
	if [[ $(blkid -o value --match-tag LABEL /dev/$tmpDrive) -eq "KEYS" ]]; then
		echo "File Label: success"
	else
		echo "File Label not correct. "
	fi

	# move files
	mkdir /media/KEYS
	mount /dev/$tmpDrive /media/KEYS
	cp keyfile /media/KEYS
	chown root /media/KEYS/keyfile
	chmod 400 /media/KEYS/keyfile

	# check to make sure the folder is there and the drive is mounted. 
	

	# setup the FDE config
	modify_fde
}

modify_fde(){
	# should add a check to see if the device has none luks configured. 
	sed -i 's;none luks;/dev/disk/by-label/KEYS:keyfile luks,keyscript=/lib/cryptsetup/scripts/passdev;g' /etc/crypttab

	#need to update the init. 
	update-initramfs -u

	# at this point the USB should be fully setup.  
	exit
}

## Main Function
list_devices
