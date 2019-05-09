#!/bin/bash

while read -r url; do
	dirb https://$url /usr/share/wordlists/dirb/common.txt.bak -r -z 100 -o "$url.txt"  </dev/null
done < https.txt.bak
