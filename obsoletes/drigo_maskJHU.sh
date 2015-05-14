#!/bin/bash
#Rodrigo Perea
#Date modified: 10/31/2013
#rperea@kumc.edu
#Goal: This script will take all the mask* tracts and compilate the mean values of each tract from the first argument such as all_sFA.nii.gz or all_sRD.nii.gz

#REQUIREMENTS:
#



SOURCE=$( pwd )
IMAGE=$1

if [ $1 -z ] ; then
    echo "Error.
Input the image you want to retrieve the mean values as the first argument. (e.g. drigo_maskJHU all_smFA.nii.gz ).

Make sure mask* tract are also copied in the same file. You can retreive them from kum-rhonea2:/BRAIN/ATLASA_DTI"
    exit
fi






for MASK_TRACT in $( ls mask* )
do
echo "Working on tract $MASK_TRACT ... "

#Mask out for multiplying the all_*.nii.gz images to each tract...
MASKOUT=${MASK_TRACT/*mm_}
TEMP=temp
echo "MASKOUT is $MASKOUT. Processing in $MASK_TRACT "
fslmaths $IMAGE -mul $MASK_TRACT $TEMP
fslstats -t $TEMP -M >> means_${MASKOUT}.txt 
rm temp*
done
