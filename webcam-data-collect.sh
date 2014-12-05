#!/bin/sh

./get_image_link_webcam image_upload.txt
./detect_and_id webcam_link.txt > webcam_parsed.txt
./parse_face_detection webcam_parsed.txt
./landmark webcam_detected_parsed.txt > webcam_landmarked.txt
./parse_landmarks webcam_landmarked.txt

rm file_name.txt
rm image_upload.txt
rm webcam_link.txt
rm webcam_parsed.txt
rm webcam_detected_parsed.txt
rm webcam_landmarked.txt
