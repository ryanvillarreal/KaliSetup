#!/usr/bin/env python

# List out all IP addresses in a specified range and write to a file.

def ipList():
    network = raw_input('Enter network portion:')
    lower = int(raw_input('Enter lowest value:'))
    higher = int(raw_input('Enter highest value:'))
    diff = higher - lower
    if network.endswith('.'):
        for i in range(diff + 1):
            print (network + str(lower))
            lower = lower + 1

if __name__ == "__main__":
	ipList()

