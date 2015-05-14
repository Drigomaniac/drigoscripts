#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#PLEASE ADD DESCRIPTION HERE:!!!!!!
#
#
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.


SOURCE=$( pwd )

#Checking what you are doing.....
if  [ $1 = "--help" ] ; then
    echo "Instructions to be entered here....
\$1 should be the start of the HSC number...
"
    exit
fi



for DIR in  $(ls -d $1* ) ;
do
    DIRtemp=$(basename $DIR)
#    DIRA=${DIRtemp/.bedpostX}
    #This will create a directory called ... into each folder
    TT="THAL_TRAC"
    
    
###ALL THIS IS PRE-PROCESSING BEORE TRACTROGRAPHY
###I JUST COPIED THE SEGMENTATIONS FROM FS AND NODIF BRAIN AND PUT THEM INTO
###STANDARD SPACE
    echo "In directory $DIR"
    #echo "Copying data.nii.gz from bedpost_in to bedpostX..."
    
    #Copying the nodif_brain form previous bedpostx directory
   #cp $SOURCE/../BEDPOSTx_in/$DIRA/data.nii.gz $DIR/nodif_brain.nii.gz

    #echo  "Converting FS brain and aseg_aparc to NIFTII.."
    #converting th *.mgz images to niftii gzipped format (nii.gz)
    #mri_convert ../FSs/${DIRA}_FS/mri/brain.mgz $DIR/FS_btemp.nii.gz
    #mri_convert ../FSs/${DIRA}_FS/mri/aparc+aseg.mgz $DIR/FS_aatemp.nii.gz

   #echo "Reorienting $DIRA brain and apar_aseg"
   #reorienting the copied images from FS
   #fslreorient2std $DIR/FS_btemp.nii.gz $DIR/FS_brain.nii.gz
   #fslreorient2std $DIR/FS_aatemp.nii.gz $DIR/FS_aparc_aseg.nii.gz
#"




###############################
#NOW TIME FOR MASKING OUR REGIONS THAT WILL GO INTO OUR TRACTOGRAPHY
   mkdir -p $DIR/$TT
    #Values are:
    #49 --> R-Thalamus, 10 --> L-Thalamus
    #1006 --> L-Enthorinal 2006 --> R-Enthorinnal
    #1/2.008 -->InfParietal, 1/2.009-->Inf.Temp
    #1/2.011 -->LatOcci, 1/2.12-->LatOrbFrontal
    #1/2.028 -->SupFron, 1/2.029 -->SupParietal
   
    

   #MAKING ALL THE CORTICAL REGIONS....
   declare -a CORTICAL=( L-RosMidFr L-FrPole L-LatOrbFr L-MedOrbFr L-SupFr  L-ParsTriang L-CauMiddFr L-ParPerCu L-Insula L-PreCentral \
       L-PostCentral L-SupraMarg L-SupTemp L-TempPole L-MidTemp L-InfTemp L-InfPar L-SupPar L-LatOcc L-Fusi \
       L-Entho L-ParaHipp L-Lingual L-ParaCentral L-Cuneus L-PreCuneus L-IsthCing L-PostCing L-CauAntCing L-RosAntCing)
   declare -a CORNUM=( 1027 1032 1012 1014 1028 1020 1003 1018 1035 1024 \
       1022 1031 1030 1033  1015 1009 1008 1029 1011 1007 \
       1006 1016 1013 1017 1005 1025 1010 1023 1002 1026)
   
   tractcounter=0
   #while [ $tractcounter -le 29 ]
   #do
   #    echo "The tract ${CORTICAL[(($tractcounter))]} is ${CORNUM[(($tractcounter))]} "
   #    fslmaths $DIR/FS_aparc_aseg.nii.gz -thr ${CORNUM[(($tractcounter))]} -uthr ${CORNUM[(($tractcounter))]} $DIR/$TT/${CORTICAL[(($tractcounter))]}
   #       tractcounter=$((tractcounter+1))


   #done	

#   echo "Thalaming...."
 #      fslmaths $DIR/FS_aparc_aseg.nii.gz -thr 10 -uthr 10 $DIR/$TT/Thalamus-L 


   #########Creating the registration models on each directory

   #flirt -in $DIR/nodif_brain -ref $DIR/FS_brain -omat $DIR/xfms/diff2str.mat -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 6 -cost corratio 
   
   #convert_xfm  -omat $DIR/xfms/str2diff.mat -inverse $DIR/xfms/diff2str.mat
  # mkdir -p $DIR/R-Thalamus-Tract
#   mkdir -p $DIR/L-Thalamus-Tract




#############Create target masks necessary for tracking
#
#
#
#
#
#
   TTR="Tracts_Intensity_BAK"
   mkdir $DIR/$TT/$TTR
   echo "Making a backup Tract with their intensity..."
   cp $DIR/$TT/* $DIR/$TT/$TTR


   for TARGET in $(ls $DIR/$TT/L-* ) ; 
   
   do

       echo "Doing...  fslmaths $TARGET -div $TARGET $TARGET"
       fslmaths $TARGET -div $TARGET $TARGET
    #   echo "$SOURCE/$target" >> $DIR/L-Thalamus-Tract/targets.txt"

   
done
   
done
