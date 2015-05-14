#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Step 0. Preprocessing
#Copying the necessary bedpost_in files (data, nodif_brain) to the bedpost_out
#folders
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.


#---> This script might not work if slight modifications are not given due
#     to folder specific locations...

SOURCE=$(pwd)
CDIR=$(basename $SOURCE)


if [ -z $@ ] ; then
    echo -e "\n Error!"
    echo -e "Please enter the prefix study (e.g. 11883*, omit the '*') as the first argument \n "
    exit 1
fi


for DIR in  $(ls -d $1* ) ;
do
    DIRtemp=$(basename $DIR)
    
###ALL THIS IS PRE-PROCESSING BEORE TRACTROGRAPHY
###I JUST COPIED THE SEGMENTATIONS FROM FS AND NODIF BRAIN AND PUT THEM INTO
###STANDARD SPACE
    echo "In directory $DIR with basename $CDIR"
    cp $SOURCE/../${CDIR/_out/_in}/${DIR//.bedpostX}/data.nii.gz $DIR/nodif_brain.nii.gz
    cp $SOURCE/../${CDIR/_out/_in}/${DIR//.bedpostX}/nodif_brain_mask.nii.gz $DIR/nodif_brain_mask.nii.gz
done
