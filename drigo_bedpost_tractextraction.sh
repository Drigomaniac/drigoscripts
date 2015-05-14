#!/bin/bash
#Rodrigo Perea
#Goal: This script takes * (e.g. RD) normalized maps in an all_*.nii.gz (all_RD.nii.gz) generally coming from tbss_4 4D volume and gives mean values for the specific atlas regions from JHU. 
#TO RUN
#  $drigo_JHUmeans.sh all_smRD.nii.gz <either '25' or 'labels' depending on the trac you want to use>



SOURCE=$( pwd )
#Variables to initialize
IMAGE=$1
#declare -a PATHS=( Occipital Parietal PostCentral PreCentral PreFrontal Temporal )
    

NUMBER=0
CUTOFF=0
for TRACT in $( ls $1* ) 
do    
    echo "in $TRACT..."
    NUMBER=$(fslstats $TRACT -R | awk '{print $2}')
    PERC=0.1
    CUTOFF=$(echo "$NUMBER*$PERC" | bc );
    echo "Highest intensity is $NUMBER and $PERC cutoff is $CUTOFF"
   fslmaths $TRACT -thr $CUTOFF cutoff_${PERC}_${TRACT 
    echo "Flirting....structural to diffusion space..."
  #  flirt -in cutoff_${PERC}_${TRACT} -ref nodif_brain.nii.gz -applyxfm -init str2diff.mat -out str2diff_${PERC}_${TRACT}
    
    #AFTER running it with target* as the $1, then comment out the flirt line and rerun it to cutoff the str2diff tracts....(to thin them out...)
done

