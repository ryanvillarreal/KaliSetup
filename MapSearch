#!/usr/bin/python3
import requests
from termcolor import colored

base_url = <base_url>/Scripts/"

def open_teh_file(filename):
	with open(filename, 'r') as file:
		for line in file.readlines():
			extension = line.strip()
			make_teh_request(base_url + extension + ".map")

# function opens a file of known JS extensions in the format: client.js
# can be grabbed from Firefox developer tools Network tab 
# right click on main 200 request --> Save All As HAR --> grep for "URL:" "https://" to get list of network resources
def make_teh_request(url):
	r = requests.get(url)
	if r.status_code == 200:
		out = url + " - " + str(r.status_code)
		#print (url + " - " + str(r.status_code))
		print (colored(out,'green'))
	else:
		out = url + " - " + str(r.status_code)
		print (out)


#make_teh_request(base_url, extension)
open_teh_file("./extensions.txt")
