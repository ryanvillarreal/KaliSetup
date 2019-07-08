#!/bin/bash

while read -r ip; do
	echo "Checking %ip";
	nslookup $ip | grep name >> output.txt
done < full_ip.txt
