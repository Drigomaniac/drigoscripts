#!/bin/bash
#Rodrigo Perea
#Goal: This script takes * (e.g. RD) normalized maps in an all_*.nii.gz (all_RD.nii.gz) generally coming from tbss_4 4D volume and gives mean values for the specific atlas regions from JHU. 
#TO RUN
#  $drigo_JHUmeans.sh all_smRD.nii.gz <either '25' or 'labels' depending on the trac you want to use>



SOURCE=$( pwd )

#if [ $1 -z ] ; then
#    echo "Error.
#Input the image you want to retrieve the mean values as the first argument. (e.g. drigo_JHUmeans all_smFA.nii.gz )"
#    exit
#fi


#Variables to initialize
IMAGE=$1
#TEMP=$3


#echo "Where are the tracts located (if in /BRAIN/ATLAS_DTI/masks_thr25_1mm  hit enter) ?"
#read -e TRACTDIR
#TRACTDIR="/BRAIN/ATLAS_DTI/mask_JHU_ICBM_labels_1mm"


#if [ $TRACTDIR -z ]; then
#    TRACTDIR="/BRAIN/ATLAS_DTI/masks_thr25_1mm"
#fi



#echo "What is the prefix of the tracts (if mask_thr25_1mm_ , hit enter)? "
#read -e TRACTPREFIX
#TRACTPREFIX="mask_JHU_ICBM_labels"

#if [ $TRACTPREFIX -z ] ; then
#    TRACTPREFIX="mask_thr25_1mm_"
#fi
COUNTER=0

    declare -a TRACACRO=( 11883_087_01_FA.nii.gz 11883_089_01_FA.nii.gz 11883_090_01_FA.nii.gz 11883_092_01_FA.nii.gz 11883_093_01_FA.nii.gz 11883_094_01_FA.nii.gz 11883_099_01_FA.nii.gz 11883_101_01_FA.nii.gz 11883_104_01_FA.nii.gz 11883_110_01_FA.nii.gz 11883_116_01_FA.nii.gz 11883_118_01_FA.nii.gz 11883_121_01_FA.nii.gz 11883_122_01_FA.nii.gz 11883_125_01_FA.nii.gz 11883_126_01_FA.nii.gz 11883_127_01_FA.nii.gz 11969_036_01_FA.nii.gz 11969_039_01_FA.nii.gz 11969_043_01_FA.nii.gz 11969_047_01_FA.nii.gz 11969_048_01_FA.nii.gz 11969_050_01_FA.nii.gz 11969_052_01_FA.nii.gz 11969_053_01_FA.nii.gz 11969_055_01_FA.nii.gz 11969_058_01_FA.nii.gz 11969_060_01_FA.nii.gz 11969_062_01_FA.nii.gz 11969_063_01_FA.nii.gz 11969_065_01_FA.nii.gz 11969_066_01_FA.nii.gz 11969_068_01_FA.nii.gz 11969_070_01_FA.nii.gz 11969_072_01_FA.nii.gz 11969_073_01_FA.nii.gz 11969_074_01_FA.nii.gz 11969_075_01_FA.nii.gz 11969_077_01_FA.nii.gz 11969_078_01_FA.nii.gz 11969_081_01_FA.nii.gz )


    for FILE in $( ls ./vol* ) 
    do
	VOL=${TRACACRO[ $COUNTER ]}
	VOL=${VOL/\.nii.gz}
	VOL=${VOL}_MD.nii.gz
    echo "Vol $FILE is $VOL and counter $COUNTER "
    let COUNTER=COUNTER+1
    mv $FILE $VOL
   
#"

    done
