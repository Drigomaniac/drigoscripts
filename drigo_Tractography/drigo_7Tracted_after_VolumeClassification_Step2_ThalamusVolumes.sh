#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Goal: This derives the classification targets and thresholds the data to specific connectivity values or
#       (4a Reference: PMID: 20452099 ) in regards to a constant proportion of the total number of 
#       permutations(Part 4b Reference: PMID:17499163 ) . 



#This script have several steps to collect data after tractography has been run
SOURCE=$(pwd)
CDIR=$(basename $SOURCE)

#(Variable for STEP 1-2) Tractography folder variable and output 
LTRACT="7L-Thalamus-Tract"
bigL="biggest_7L_Thalamus.nii.gz"
RTRACT="7R-Thalamus-Tract"
bigR="biggest_7R_Thalamus.nii.gz"

#(Variables for  STEP 3 and 4) Thalamus volumes
LTHALAMUS="Thalamus-L.nii.gz"
RTHALAMUS="Thalamus-R.nii.gz"


#(Variables for STEP 4) For bringing the FA/RD to
DTIFIT_FOLDER="/BRAIN/THESIS_WORK/RAW_IMAGES/ADEPT/DTIFIT_ALL"
#DTIFIT_FOLDER/BRAIN/THESIS_WORK/RAW_IMAGES/TEAM/DTIFIT_ALL
DTIBRAIN="nodif_brain.nii.gz"
#THRESHOLD=99
INT_THRESHOLD=.15 #Which is 15% of the intensity value

#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------




if [ -z $@ ] ; then
    echo -e "\n Error!"
    echo -e "Please enter the prefix study (e.g. 11883*, omit the '*') as the first argument \n "
    exit 1
fi

#$1 should be the directory of each folder 
for DIR in  $(ls -d $1* ) ;
do
echo "in $DIR (thalamus left and right)... "    

#Step 3: Thalamus Volumes
fslstats $DIR/$LTHALAMUS -V | awk '{print $1}'
fslstats $DIR/$RTHALAMUS -V | awk '{print $1}'
#-----------------------------------------------------------------------------------------------------------





done

