#!/bin/bash

for FILE in $( ls ./*.nii.gz ) 
do
echo "File name to be converted... $FILE "
mri_convert $FILE ${FILE/.nii.gz}.img
done
