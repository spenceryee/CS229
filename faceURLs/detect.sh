#!/bin/sh

for var in 1 2 3 4 5 6 7 8
do
	echo "PROCESSING FILE $var"
	./detect_and_id $var > ${var}_detected.txt
done
