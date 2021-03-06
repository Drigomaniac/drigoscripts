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

    declare -a AB=(CTL CTL CTL CTL EXER EXER CTL EXER EXER CTL EXER EXER EXER CTL EXER EXER  CTL CTL CTL EXER EXER CTL EXER CTL CTL CTL EXER CTL CTL EXER EXER EXER )

    declare -a ID=( _001_ _003_ _005_ _007_ _008_ _009_ _011_ _012_ _014_ _016_ _017_ _018_ _019_ _021_ _022_ _023_ _024_ _025_ _027_ _028_ _030_ _031_ _033_ _034_ _036_  _037_ _039_  _043_  _047_  _048_  _050_  _052_)

    for FILE in {0..31}
    do
	ABA=${AB[ $COUNTER ]}
	IDA=${ID[ $COUNTER ]}
	drigo_renamer -addbeg $IDA $ABA 
	
#	cp ../../../../42/DTIFIT/*$IDA*MD* ./
	let COUNTER=COUNTER+1

   done
