#!/bin/bash

while read -r url; do
	nikto -h "https://$url" -o "$url.txt" -maxtime 1h </dev/null
done < tmp.txt
