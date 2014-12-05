#!/bin/sh

echo $1
echo $1 > image_upload.txt
curl -H Expect: -F key="06GIJRTW05a186fcad387195ed87c5d3ab0e2395" -F fileupload="@$1" -F xml=yes -# "https://api.imageshack.com/v2/images" >> image_upload.txt
