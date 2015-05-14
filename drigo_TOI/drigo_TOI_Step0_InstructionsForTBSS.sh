#!/bin/bash
#Rodrigo Perea
#Goal: 
#TO RUN
#  $drigo_JHUmeans.sh all_smRD.nii.gz <either '25' or 'labels' depending on the trac you want to use>



SOURCE=$( pwd )
#Variables to initialize
IMAGE=$1

echo "The goal of this script is to linearly registered all images to a specific target. 
 This scripts has not been implemented because it can be easily done by running the first TBSS steps:


1st: Put all the FA* into a folder, then run:
     tbss_1_preproc: Prepares  (it will format your FA data to tbss format)
     tbss_2_reg -T: Nonlinear registration of all the FA images into 1x1x1mm standard space (using FMRIB_58 as target standard space)
     tbss_3_postreg -T (optional): creates the mean FA image and skeletonises it
     tbss_4_prestats 0.1 (optional): project all subjects' FA data onto the mean FA skeleton

"

