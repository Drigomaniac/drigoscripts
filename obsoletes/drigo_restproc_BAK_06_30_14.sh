#!/bin/bash
#===========================================================================
# README:  This script implements the data pre-processing of resting-state scans
#   Created for Kyle Simmons, Laureate Institute and implemented as 
#   afni_restproc.py
#
# Script modified from KUADC by rperea on 06_30_2014
#=============================================================================



#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ SETTING UP \\\\\\\\\\\\\\\\\\\\\\\\\
#=============================================================================
#=============================================================================
#SET UP BEFORE RUNNING THIS SCRIPT



#Dependencies:
#  1. Anatomical (MPRAGE) image  in the following format
      # <HSCNUMBER>_<SUBJECT_NUMBER>_<TIMEPOINT>_MPRAGE.nii 
      #Example -->  13007_666_01_MPRAGE.nii 

#  2. Resting state images in NIFTII format:
      # <HSCNUMBER>_<SUBJECT_NUMBER>_<TIMEPOINT>_RESTING1.nii 
      #Example -->  13007_666_01_RESTING1E.nii 

#  3. FreeSurfer Folder with each subject's segmentation
      # <HSCNUMBER>_<SUBJECT_NUMBER>_<TIMEPOINT>_FS/
      #Example: 13007_666_01_FS 

#==============================================================================
#==============================================================================

#Present working directory...
SOURCE=$(pwd)

#The following lines are commented out due to
#afni GUI..
#Create a Folder where all our process will be saved
PROC_DIR=${SOURCE} #/RestProc_Processed
#mkdir -p $PROC_DIR

#For loop to initialize every subject....
for  SUBJECT_MPRAGE in $(ls  *MPRAGE.nii );
do       
    
#INITIALIZING VARIABLES
    SUBJ=${SUBJECT_MPRAGE//_MPRAGE*}
    SUBJ_MPRAGE=$SUBJECT_MPRAGE
    SUBJ_RESTING1=${SUBJECT_MPRAGE/MPRAGE/RESTING1}


#ANATOMICAL VARIABLES
    #Set the number of slices in the anatomical image (MPRAGE)
    ANAT_SLICES='3dinfo -nk $SUBJ_MPRAGE' #(outputs usually 176)
    
    
    
#RESTING VARIABLES
    #Check if a 2nd Resting state exists....
    if [ -a ${SUBJ_MPRAGE/MPRAGE/RESTING2} ] #if it exists..then
    then
	SUBJ_RESTING2=${SUBJ_MPRAGE/MPRAGE/RESTING2}
	RESTRUN=1
    else
	SUBJ_RESTING2='null'
	RESTRUN=2
    fi

    #Variables to remove first 2 acquisitions due to
     # brightness in the BOLD signal
    TR_SKIP=2 #If you change this, you must also change 
               #other numbers below that relate to volumes to skip
   
    CENSOR_ENORM_SIZE=0.3 #threshold of the euclidean norm 
                           #of movement to censor
    CLIP_LEVEL=-120
    
    
    #Set Resting1 parameters
    TR_LENGTH='3dinfo -tr $SUBJ_RESTING1'
    VOLS=$(3dinfo -nv $SUBJ_RESTING1)  #105
    SLICES=$(3dinfo -nk $SUBJ_RESTING1) #50
    TR_COUNTS=$(ccalc -i $VOLS - $TR_SKIP)
 
    
#===========================================================================
#===========================================================================
     echo "

"
     echo "
SUBJECT ANAT is: $SUBJ_MPRAGE
SUBJECT REST1 is: $SUBJ_RESTING1
SUBJECT REST2 is: $SUBJ_RESTING2

"
       
#===========================================================================
#===========================================================================
#Starting Actually AFNI CODE HERE....


#Step 1._CLIPPING THE ANATOMY IMAGE (MPRAGE)
#Variables
     SUBJ_CLIP=clip.${SUBJ}.anat.raw+orig

	#---> CUTS the MPRAGE because problems with the jaw brightness 
              #(maybe part of a Skyra problem). 
     @clip_volume -input $SUBJ_MPRAGE -below $CLIP_LEVEL -prefix $SUBJ_CLIP

	#- This creates:
        #       clip.13007_666_01.anat.raw+orig.HEAD
	#	clip.13007_666_01.anat.raw+orig.BRIK     
     
     
#Step 2._ DEOBLIQUING THE ANATOMY IMAGE
#Variables
     SUBJ_ANAT_DEOBQ=${SUBJ}.anat.deob+orig
       
     #Deobliquing the orientation of the MRI acquisition in the MPRAGE
     3dWarp -deoblique -prefix $SUBJ_ANAT_DEOBQ $SUBJ_CLIP 
     
   	#- This creates:  
	#	+ 13007_666_01.anat.deob+orig.BRIK  [26.1 MB]
	#	+ 13007_666_01.anat.deob+orig.HEAD  [2.8 KB]



#Step 3._ 3dTshift to the RESTING state NIFTII file. 
#Variable
     SUBJ_3DTSHIFT=pb00.${SUBJ}.RS1.tshift 
      
     #3dTshifting is a mathematical compensation for acquiring 
     #the interleaved slices at different times
     3dTshift -tpattern altplus -tzero 0 -quintic -prefix $SUBJ_3DTSHIFT $SUBJ_RESTING1

  	#- This creates:  
	#	+ pb00.13007_666_01.RS1.tshift+orig.BRIK  [26.1 MB]
	#	+ pb00.13007_666_01.RS1.tshift+orig.HEAD  [2.8 KB]
    

#Step 5._ DEOBLIQUING THE BOLD IMAGE
#Variables
     SUBJ_REST1_DEOBQ=pb00.${SUBJ}.RS1.tshift.deob
     
     #--->Deoblique the BOLD 
     3dWarp -deoblique -prefix  $SUBJ_REST1_DEOBQ  ${SUBJ_3DTSHIFT}+orig
     
	#- This creates:    
        #     +   pb00.13007_666_01.RS1.tshift.deob+orig.BRIK  [97 MB]
        #     +   pb00.13007_666_01.RS1.tshift.deob+orig.HEAD  [12 KB]




done
