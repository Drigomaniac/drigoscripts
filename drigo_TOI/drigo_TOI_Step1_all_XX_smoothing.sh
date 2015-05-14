#!/bin/bash
#Rodrigo Perea
#Goal: Type --help or check the help if statement 
#TO RUN
#  $drigo_JHUmeans.sh all_smRD.nii.gz <either '25' or 'labels' depending on the trac you want to use>



SOURCE=$( pwd )
#Variables to initialize
IMAGE=$1




#INITIALIZING VARIABLES
ALL_DIFF=all_${1}.nii.gz
ALL_DIFF_1000=all_1000_${1}.nii.gz
ALL_sDIFF=all_s${1}.nii.gz
DIREC=${1}_TOI

#---------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------
if [ $1 = "--help" ] ; 
then
    echo "Enter FA/RD as the first argument and run it from ../stats present directory"
    echo "This script will:
     1. Create a $\1_FA (e.g. FA_TOI) folder
     2. Copy the all_FA.nii.gz into FA_folder
     3. Smoothing the all_FA.nii.gz image to FWM 0.8
    
"
exit
fi

if [ -z $1 ] ; then
    echo "please enter FA or RD as the 1st argument"
    echo -e "ERROR! \n "
    
    
else
    mkdir -p $DIREC
    echo "Copying $ALL_DIFF to $SOURCE/$DIREC ... "
    cp ./stats/${ALL_DIFF} $DIREC
    if [ $1 = "RD" ] ;
    then
	echo "Multiplying by 1000... " 
	fslmaths  $DIREC/$ALL_DIFF -mul 1000 $DIREC/$ALL_DIFF_1000 
	

    echo "Smoothing $ALL_DIFF to an equivalent 2mm FWHM..."
    fslmaths $DIREC/$ALL_DIFF_1000  -s 0.85 $DIREC/$ALL_sDIFF

else
echo "Smoothing $ALL_DIFF to an equivalent 2mm FWHM..."
    fslmaths $DIREC/$ALL_DIFF  -s 0.85 $DIREC/$ALL_sDIFF
fi
fi


