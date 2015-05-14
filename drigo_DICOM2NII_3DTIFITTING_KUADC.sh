#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Created 27/01/2014
#Objective: 
#This script 

#PLEASE MAKE SURE YOU KNOW HOW TO USE IT BEFORE EXECUTE IT ````
#IT COULD MODIFIED YOUR FILES AND THERE IS NO UNDO OF IT!

#Objective:A continuation of drigo_DICOM2NII (2nd step...creating a brain mask)


#THIS WILL USE DCM2NII and NEEDS THE 11883_XX/DICOM format!!
#MAKE SURE YOU FORMAT AS IT LOOKS....

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#HERE IS AN EXAMPLE INPUT:
SOURCE=$( pwd )







########################################################################################
########################################################################################
#CODING PART TO CONVERT DICOM TO NIFTIIII
    
for DIR in $( ls -1d ./118*/ ) ; 
do
echo "In directory $DIR ... "
echo " basename is $( basename $DIR ) " 

#Here we will create the first NIFTII file to start within the folder
DTIEC=$( basename $DIR )_DTIec.nii.gz
BVAL=$( basename $DIR ).bval
BVEC=$( basename $DIR ).bvec
BMASK=$( basename $DIR )_bet
#echo "$DTIEC"


#Here we will create the brain mask and then we need to check them....
echo "Dtifiting... dtifit -k $DTIEC -o $(basename $DIR) -m ${BMASK}_mask -r $BVEC -b $BVAL$BMASK "

dtifit -k $DTIEC -o $(basename $DIR) -m ${BMASK}_mask -r $BVEC -b $BVAL







done


    
