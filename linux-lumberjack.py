#!/usr/bin/python
from shutil import copyfile
from shutil import move
from os import remove
import os
import os.path
import sys

homedir = os.environ['HOME']
target_file = homedir + "/.bashrc"
backup_file = homedir + "/.backup-bashrc"
new_file = homedir + "/.newbashrc"
interfaces = []

def get_network_interfaces():
	for line in open('/proc/net/dev', 'r'):
		if line.find(":") != -1 and line.find("lo") == -1:
			interfaces.append(line.split(":")[0].strip())

def modify_terminal_line(selected_interface):
	with open(new_file, "w") as newfile:
		with open (target_file) as oldfile:
			for line in oldfile:
				if line.find("PS1") != -1 and not line.strip().startswith("#"):
					### This modifies the terminal to show timestamp, IP, and current directory inline
					newfile.write("PS1=\'[`date  +\"%d-%b-%y %T\"`]\\[\\033[01;31m\\] `ifconfig " + selected_interface + " 2>/dev/null | sed -n 2,2p | cut -d\" \" -f 10`\\[\\033[00m\\] \\[\\033[01;34m\\]\\W\\[\\033[00m\\] > \'" + "\n")
				else:
					newfile.write(line)
	remove(target_file)
	move(new_file, target_file)

def main():
	if os.path.isfile(target_file):
		### Figure out what network interfaces are available
		selected_interface = None
		get_network_interfaces()

		### If there is only one interface, don't bother asking the user - just set that
		if len(interfaces) != 0 and len(interfaces) == 1:
			selected_interface = interfaces[0]
		else: ### Otherwise, ask the user to select from the available network interfaces
			while selected_interface not in interfaces:
				selected_interface = raw_input("Choose your active interface: " + ' '.join(interfaces) + "\n")

		copyfile(target_file, backup_file) ### make a back-up of the .bashrc - just in case :)
		modify_terminal_line(selected_interface)
	else:
		print "Something's wrong... there's no \".bashrc\" file!"

if __name__ == "__main__":
	main()
