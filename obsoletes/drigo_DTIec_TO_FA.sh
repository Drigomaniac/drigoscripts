#!/bin/bash
SOURCE=$(pwd)

echo " Insert DTIec folder"
#read -e SOURCER
SOURCER="../../../../../RAW_IMAGES/ADEPT/NIFTII/65/CrossSectional/"

for FILE in $( ls $SOURCER)

do
FILEEX=${FILE/_DTIec.nii.gz}
echo "In file $FILEEX"

#for Example ADEPT cross
cp /BRAIN/THESIS_WORK/RAW_IMAGES/ADEPT/NIFTII/65/DTIFIT/$FILEEX*MD* $SOURCE

#for Example TEAM cross
#cp /BRAIN/THESIS_WORK/RAW_IMAGES/TEAM/NIFTII/65/DTIFIT/$FILEEX*bet_mask* $SOURCE

done
