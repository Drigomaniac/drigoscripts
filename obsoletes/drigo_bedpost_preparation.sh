#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#This script was modified for a 4D volumes with the first being the b0 and 64 directions. 
#It will run and prepare your data for bedpostx.
#Make sure you run it from the folder that contains your bvecs, bvlas, aand brain mask, DTI 4D images are stored (being the first b0 and the other the DWIs).
#For example:
#ls ./* should give you
#$ ls ./<Current Directory>
# bvecs bvals
#11883_065_02_DTIec.nii.gz 11883_090_01_DTIec.nii.gz 11883_101_01_DTIec.nii.gz 11883_122_01_DTIec.nii.gz 13007_003_01_DTIec.nii.gz 13007_010_01_DTIec.nii.gz
#11883_071_02_DTIec.nii.gz 11883_092_01_DTIec.nii.gz 11883_104_01_DTIec.nii.gz 11883_125_01_DTIec.nii.gz 13007_004_01_DTIec.nii.gz
#and fslinfo 11883_065_02_DTIec.nii.gz
#fslinfo 11883_065_02_DTIec.nii.gz 
#data_type      INT16
#dim1           128
#dim2           128
#dim3           75
#dim4           65
#datatype       4
#pixdim1        2.3437500000
#pixdim2        2.3437500000
#pixdim3        2.0000000000
#pixdim4        1.0000000000
#cal_max        0.0000
#cal_min        0.0000
#file_type      NIFTI-1+

#
#
#
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.


SOURCE=$(pwd )

#Checking what you are doing.....
if  [ $1 = "--help" ] ; then
    echo "This script was modified for a 4D volumes with the first being the b0 and 64 directions. 
It will run and prepare your data for bedpostx.
Make sure you run it from the folder that contains your bvecs bvals, binary brain mask,  and  DTI 4D images are stored (being the first b0 and the other the DWIs).

TO RUN IT:
drigo_bedpost.sh <DTI extension files. Eg. drigo_bedpost.sh .nii.gz  NO * AT THE END!!>


"
    exit
fi

echo "Extension file? (do not include *. Enter for ec.nii.gz)"
read $EXT

if [ -z $EXT ] ;
then
EXT="ec.nii.gz"
fi



echo "How many directions? (for 65. 1 b0 and 64 DWIs, hit enter)"
read $DIRECTIONS

if [ -z $DIRECTIONS ]
then
DIRECTIONS="65"
fi



################################################
#Preparing the data...
#FOR LOOPS
echo $SOURCE
for FILE in $( ls  $SOURCE/*$EXT); 
 do
    echo $FILE
    FILEB=$( basename $FILE )
    echo $FILEB 
    NAME=${FILEB//$EXT}
    echo $NAME

    #Creating directions with their respective names...
    BEDPOSTDIR=${NAME/DTI/BEDPOST}


    mkdir -p $BEDPOSTDIR
    cp ${NAME}ec.nii.gz $BEDPOSTDIR/data.nii.gz
    cp ${NAME/_DTI}_bet_mask.nii.gz $BEDPOSTDIR/nodif_brain_mask.nii.gz
    cp bvals_65 $BEDPOSTDIR/bvals
    cp bvecs_65 $BEDPOSTDIR/bvecs

done

