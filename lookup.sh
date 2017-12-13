#!/bin/bash

while read -r ip; do
	nslookup $ip | grep name | cut -d"=" -f2 | cut -d" " -f2
done < full_ip.txt
