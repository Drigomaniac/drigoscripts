#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Created 10/30/2012
#Objective: 
#This script 

#PLEASE MAKE SURE YOU KNOW HOW TO USE IT BEFORE EXECUTE IT ````
#IT COULD MODIFIED YOUR FILES AND THERE IS NO UNDO OF IT!
SOURCE=$( pwd )

#
#
#
#############RUN FROM HPC SERVER!!!!!!!!!!!!!
#
#
#







#######################################################################################
########################################################################################
#CODING PART TO CONVERT DICOM TO NIFTIIII
    
#CREATE QSUBS DIRECTORY...
mkdir -p $SOURCE/QSUBS

for DIR in $( ls -1d ./* ) ; 
do
DIRA=$(basename DIR)
echo "In directory $DIR ... "
echo "
#PBS -N ${DIR/bedpostX}
#PBS -l nodes=3:ppn=2
#PBS -q default      

cd $SOURCE  
mkdir -p $DIR/L-Thalamus-Tract 
$FSL_DIR/bin/probtrackx2 -x $DIR/THAL_TRAC/L-Thal.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --xfm=$DIR/xfms/str2diff.mat --meshspace=freesurfer --seedref=$DIR/FS_brain.nii.gz --forcedir --opd -s $DIR/merged -m $DIR/nodif_brain_mask --dir=$DIR/L-Thalamus-Tract --targetmasks=$DIR/L-Thalamus-Tract/targets.txt --os2t 

" 
#>> $QSUBS/$DIRA.qsub



done


    
