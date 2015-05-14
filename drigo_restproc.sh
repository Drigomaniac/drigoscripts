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


#Step 1._ANAT: CLIPPING THE ANATOMY IMAGE (MPRAGE)
#Variables
     echo -e "\n\n\n (for KUMC-KUADC... ) STEP 1...
             CLIPPING THE ANATOMY IMAGE (MPRAGE) \n\n\n"
     SUBJ_CLIP=clip.${SUBJ}.anat.raw+orig

	#---> CUTS the MPRAGE because problems with the jaw brightness 
              #(maybe part of a Skyra problem). 

#COMMAND IN THE NEXT LINE-->
#     @clip_volume -input $SUBJ_MPRAGE -below $CLIP_LEVEL -prefix $SUBJ_CLIP
#<--
	#- This creates:
        #       clip.13007_666_01.anat.raw+orig.HEAD
	#	clip.13007_666_01.anat.raw+orig.BRIK     
#----------------------------------------------------------------------------     
     

#Step 2._ ANAT: DEOBLIQUING THE ANATOMY IMAGE
#Variables
     echo -e "\n\n\n (for KUMC-KUADC... ) STEP 2...
             DEOBLIQUING THE ANATOMY IMAGE \n\n\n"
     SUBJ_ANAT_DEOBQ=${SUBJ}.anat.deob+orig
       
     #Deobliquing the orientation of the MRI acquisition in the MPRAGE.
     #Changes orientation of the image so it looks more Afni friendly 

#COMMAND IN THE NEXT LINE-->
 #    3dWarp -deoblique -prefix $SUBJ_ANAT_DEOBQ $SUBJ_CLIP 
#<--     
   	#- This creates:  
	#	+ 13007_666_01.anat.deob+orig.BRIK  [26.1 MB]
	#	+ 13007_666_01.anat.deob+orig.HEAD  [2.8 KB]
#---------------------------------------------------------------------------




#Step 3._ BOLD: 3dTshift to the RESTING state NIFTII file. 
#Variable
     echo -e "\n\n\n (for KUMC-KUADC... ) STEP 3...
              3dTshift to the RESTING state NIFTII file. \n\n\n"
     SUBJ_3DTSHIFT=pb00.${SUBJ}.RS1.tshift+orig 
      
     #3dTshifting is a mathematical time compensation for acquiring 
     #the interleaved slices at different times
#COMMAND IN THE NEXT LINE-->
 #   3dTshift -tpattern altplus -tzero 0 -quintic -prefix $SUBJ_3DTSHIFT $SUBJ_RESTING1
#<--
  	#- This creates:  
	#	+ pb00.13007_666_01.RS1.tshift+orig.BRIK  [26.1 MB]
	#	+ pb00.13007_666_01.RS1.tshift+orig.HEAD  [2.8 KB]
#---------------------------------------------------------------------------



#Step 4._ BOLD: DEOBLIQUING THE BOLD IMAGE
#Variables
     echo -e "\n\n\n (for KUMC-KUADC... ) STEP 4...
              DEOBLIQUING THE BOLD IMAGE. \n\n\n"

     SUBJ_REST1_DEOBQ=pb00.${SUBJ}.RS1.tshift.deob+orig
     
     #--->Deoblique the BOLD

#COMMAND IN THE NEXT LINE--> 
  #  3dWarp -deoblique -prefix  $SUBJ_REST1_DEOBQ  ${SUBJ_3DTSHIFT}
#<--
     #Changes orientation of the image so it looks more Afni friendly
	#- This creates:    
        #     +   pb00.13007_666_01.RS1.tshift.deob+orig.BRIK  [97 MB]
        #     +   pb00.13007_666_01.RS1.tshift.deob+orig.HEAD  [12 KB]

#**HERE, AN ADDITIOONAL CODE MIGHT BE NEEDED TO DEAL WITH 2+ RESTING STATE IMAGES...
#  -->Objective: To concatenate these 2+ Resting state images.
#---------------------------------------------------------------------------




#Step 5._ FREESURFER: PROCESSING THE SUMA FOLDER
#Variables
     FS_DIR=${SUBJ}_FS
     echo -e "\n\n\n (for KUMC-KUADC... ) STEP 5...
              PROCESSIGN THE SUMA FOLDER: $FS_DIR... \n\n\n"
     cd $FS_DIR
#COMMAND IN THE NEXT LINE-->
#     @SUMA_Make_Spec_FS -sid $FS_DIR 
#<--
     cd ..
     
#---------------------------------------------------------------------------



#Step 6._ BOLD: PULL THE FIRST 2 BOLD IMAGES 
     echo -e "\n\n\n (for KUMC-KUADC... ) STEP 6...
              PULL OUT THE FIRST 2 BOLD IMAGES. \n\n\n"
     SUBJ_REST1_BASE_EPI=${SUBJ}.RS1.base_epi
#COMMAND IN THE NEXT LINE--> 
  #   3dbucket -prefix ${SUBJ_REST1_BASE_EPI} ${SUBJ_REST1_DEOBQ}'[0..1]'
#<--
     # Extract the first 2 volumes of BOLD and create a new dataset. 
     # So we can align with a better contract the BOLD and MPRAGE
     # In other words...it pulls out vol0 and vol1 of the BOLD sequence

     	#- This creates:    
        #     +  13007_666_01.RS1.base_epi+orig.BRIK [1.8 MB]
        #     +  13007_666_01.RS1.base_epi+orig.HEAD [4.0 KB]
#---------------------------------------------------------------------------



#Step 7._ BOLD: AFNI FLOAT AND DEMEANING SPIKES OF BOLD DATA
     echo -e "\n\n\n (for KUMC-KUADC... ) STEP 7...
              AFNI DEFAULT FLOAT CONVERSION AND DEMEANING OR FILTER SPIKES. \n\n\n"


     SUBJ_REST1_FLOAT=${SUBJ}.RS1.tshift.deob.float+orig
     SUBJ_REST1_FLOAT_DESPIKE=${SUBJ_REST1_FLOAT}.despike+orig

#COMMANDS IN THE NEXT LINES--> 

#!!!!PROBLEMS WITH LIBRARIES!! LETS try it in Kus-imaging...
     3dcalc -a ${SUBJ_REST1_DEOBQ} -expr 'a' -prefix ${SUBJ_REST1_FLOAT} -float
echo "     3dDespike -NEW -nomask -prefix ${SUBJ_REST1_FLOAT_DESPIKE} -ignore $TR_SKIP \
	 ${SUBJ_REST1_FLOAT} "
#<--
     # First, it converts our dataset to float data and then it filters
     # any spike it encounters...

     	#- This creates:    
        #Floats....
        #     +  13007_666_01.RS1.tshift.deob.float+orig.BRIK [193 MB]
        #     +  13007_666_01.RS1.tshift.deob.float+orig.HEAD [ 12 KB]
        #Deskpikes...
        #     +  13007_666_01.RS1.tshift.deob.float+orig.despike+orig.BRIK [194 MB]
        #     +  13007_666_01.RS1.tshift.deob.float+orig.despike+orig.HEAD [ 8 KB]
       
#---------------------------------------------------------------------------




done
