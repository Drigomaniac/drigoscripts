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
    DIRA=${DIRtemp/.bedpostX}
    #This will create a directory called ... into each folder
    TT="R-THAL_TRAC"
    
    
###ALL THIS IS PRE-PROCESSING BEORE TRACTROGRAPHY
###I JUST COPIED THE SEGMENTATIONS FROM FS AND NODIF BRAIN AND PUT THEM INTO
###STANDARD SPACE
    echo "In directory $DIR"
 #   echo "Copying data.nii.gz from bedpost_in to bedpostX..."
    
    #Copying the nodif_brain form previous bedpostx directory
#   cp $SOURCE/../BEDPOSTx_in/$DIRA/data.nii.gz $DIR/nodif_brain.nii.gz

    #echo  "Converting FS brain and aseg_aparc to NIFTII.."
    #converting th *.mgz images to niftii gzipped format (nii.gz)
   # mri_convert ../FSs/${DIRA}_FS/mri/brain.mgz $DIR/FS_btemp.nii.gz
  #  mri_convert ../FSs/${DIRA}_FS/mri/aparc+aseg.mgz $DIR/FS_aatemp.nii.gz

 #  echo "Reorienting $DIRA brain and apar_aseg"
#   reorienting the copied images from FS
#   fslreorient2std $DIR/FS_btemp.nii.gz $DIR/FS_brain.nii.gz
#   fslreorient2std $DIR/FS_aatemp.nii.gz $DIR/FS_aparc_aseg.nii.gz
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
   declare -a CORTICAL=( R-RosMidFr R-FrPole R-LatOrbFr R-MedOrbFr R-SupFr  R-ParsTriang R-CauMiddFr R-ParPerCu R-Insula R-PreCentral \
       R-PostCentral R-SupraMarg R-SupTemp R-TempPole R-MidTemp R-InfTemp R-InfPar R-SupPar R-LatOcc R-Fusi \
       R-Entho R-ParaHipp R-Lingual R-ParaCentral R-Cuneus R-PreCuneus R-IsthCing R-PostCing R-CauAntCing R-RosAntCing)
   declare -a CORNUM=( 2027 2032 2012 2014 2028 2020 2003 2018 2035 2024 \
       2022 2031 2030 2033  2015 2009 2008 2029 2011 2007 \
       2006 2016 2013 2017 2005 2025 2010 2023 2002 2026)
   
   tractcounter=0
   while [ $tractcounter -le 29 ]
   do
       echo "The tract ${CORTICAL[(($tractcounter))]} is ${CORNUM[(($tractcounter))]} "
       fslmaths $DIR/FS_aparc_aseg.nii.gz -thr ${CORNUM[(($tractcounter))]} -uthr ${CORNUM[(($tractcounter))]} $DIR/$TT/${CORTICAL[(($tractcounter))]}
          tractcounter=$((tractcounter+1))


   done	

   echo "Thalaming...."
       fslmaths $DIR/FS_aparc_aseg.nii.gz -thr 49 -uthr 49 $DIR/$TT/Thalamus-L 


   #########Creating the registration models on each directory

   #flirt -in $DIR/nodif_brain -ref $DIR/FS_brain -omat $DIR/xfms/diff2str.mat -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 6 -cost corratio 
   
   #convert_xfm  -omat $DIR/xfms/str2diff.mat -inverse $DIR/xfms/diff2str.mat
   mkdir -p $DIR/R-Thalamus-Tract
#   mkdir -p $DIR/L-Thalamus-Tract




#############Create target masks necessary for tracking
#
#
#
#
#
#
#   TTR="Tracts_Intensity_BAK"
#   mkdir $DIR/$TT/$TTR
#   echo "Making a backup Tract with their intensity..."
#   cp $DIR/$TT/* $DIR/$TT/$TTR


   for TARGET in $(ls $DIR/$TT/R-* ) ; 
   
   do

       echo "Doing...  fslmaths $TARGET -div $TARGET $TARGET"
       fslmaths $TARGET -div $TARGET $TARGET
    #   echo "$SOURCE/$target" >> $DIR/R-Thalamus-Tract/targets.txt"

   
done
   
done
