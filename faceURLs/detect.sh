#!/bin/sh

for var in 2 3 4 5 6 7 8
do
	./detect_and_id $var > $var_detected.txt
done
