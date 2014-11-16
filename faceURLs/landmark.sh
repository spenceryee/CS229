#!/bin/sh

for var in 1 2 3 4 5 6 7 8
do
    echo "PROCESSING FILE $var"
    ./landmark ${var}_detected_parsed > ${var}_landmarked.txt
done
