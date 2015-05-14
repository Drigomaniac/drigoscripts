#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)

#Step 1. str2diff and diff2str after a Freesurfer Extraction a
#        Extracting the aparc_aseg and nodif_brain from FS. 
#        Then, I copy this files into the bedpost directory and flirt
#        values for str2diff.mat and diff2str.mat





#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.

#!!!!!
#---> This script might not work if slight modifications are not given due
#     to folder specific locations...

#!!!!!



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
    echo "In directory $DIR with basename $CDIR"
   # mri_convert $SOURCE/../FS/${DIR/.bedpostX/_FS}/mri/brain.mgz ${DIR}/FS_brain1.nii
   # mri_convert $SOURCE/../FS/${DIR/.bedpostX/_FS}/mri/aparc+aseg.mgz ${DIR}/aparc_aseg1.nii
   # fslreorient2std $DIR/FS_brain1.nii $DIR/FS_brain.nii
   # fslreorient2std $DIR/aparc_aseg1.nii $DIR/FS_aparc_aseg.nii
   # rm ${DIR}/FS_brain1.nii
   # rm ${DIR}/aparc_aseg.nii
    echo "Generating str2diff.mat ... "
    $FSL_DIR/bin/flirt -in $SOURCE/$DIR/nodif_brain -ref $SOURCE/$DIR/FS_brain.nii.gz -omat $SOURCE/$DIR/xfms/diff2str.mat -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 6 -cost corratio

    echo "Generating diff2str.mat ..."
     $FSL_DIR/bin/convert_xfm -omat $SOURCE/$DIR/xfms/str2diff.mat -inverse $SOURCE/$DIR/xfms/diff2str.mat


    
done
