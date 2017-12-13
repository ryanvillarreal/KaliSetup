#!/bin/bash

while read -r url; do
	sslscan $url >> output.txt
done < https.txt
