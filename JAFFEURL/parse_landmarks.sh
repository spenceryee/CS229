#!/bin/sh

for var in 1 2 3 4 5 6 7 8
do
    echo "PROCESSING FILE $var"
    ./parse_landmarks ${var}_landmarked.txt
done