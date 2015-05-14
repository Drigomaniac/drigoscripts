#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)

#Step 2. Freesurfer Parcellation into Thalamus and Cortical regions
#        We extracting each cortical segmentaion and the thalamus
#        from aparc_aseg.nii.gz and save them in XXX/Targets





#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.

#!!!!!
#---> This script might not work if slight modifications are not given due
#     to folder specific locations...

#!!!!!



SOURCE=$(pwd)
CDIR=$(basename $SOURCE)

if [ $1 -eq "--help" ] ; then
echo "
This script does the following:
	1. Creates the \$DIR/Targets folder
	2. Generates the subsegmentations of the 7 cortical masks (though the cortical masks
   	   are created in Step 3)
	3. Generats the left and right hemisphere exclusion masks.  
"

fi


if [ -z $@ ] ; then
    echo -e "\n Error!"
    echo -e "Please enter the prefix study (e.g. 11883*, omit the '*') as the first argument \n "
    exit 1
fi






for DIR in  $(ls -d $1* ) ;
do
    DIRtemp=$(basename $DIR)
    echo "In directory $DIR with basename $CDIR"
    TARGETS=$DIR/Targets
    TFRONTAL=$TARGETS/Frontal
    TCING=$TARGETS/Cingulate
    TPARIETAL=$TARGETS/Parietal
    TOCCIPITAL=$TARGETS/Occipital
    TTEMPORAL=$TARGETS/Temporal
    TPRECENTRAL=$TARGETS/PreCentral
    TPOSTCENTRAL=$TARGETS/PostCentral
    mkdir -p $TARGETS
    mkdir -p $TFRONTAL
    mkdir -p $TCING
    mkdir -p $TPARIETAL
    mkdir -p $TOCCIPITAL
    mkdir -p $TTEMPORAL
    mkdir -p $TPRECENTRAL
    mkdir -p $TPOSTCENTRAL

    
    #Thalamus segmentations...
    echo "Creating the Thalamus segmentations...." 
    fslmaths $DIR/FS_aparc_aseg.nii.gz -thr 49 -uthr 49 $DIR/Thalamus-R
    fslmaths $DIR/FS_aparc_aseg.nii.gz -thr 10 -uthr 10 $DIR/Thalamus-L
    
    
    #INITIALIZING CORTICAL TRACTS
    #Variables....
    
    
    #FRONTAL
    echo "In frontal..."
    tractcounter=0
    declare -a FRONTALT=( L-CauMiddFr L-FrPole L-ParPerCu L-ParsTriang	L-Insula L-LatOrbFr L-MedOrbFr	L-RosMidFr L-SupFr R-CauMiddFr R-FrPole R-ParPerCu R-ParsTriang	R-Insula R-LatOrbFr R-MedOrbFr	R-RosMidFr R-SupFr  )
    declare -a FRNUMT=( 1003 1032 1018 1020 1035 1012 1014 1027 1028  2003 2032 2018 2020 2035 2012 2014 2027 2028)
    
    #A do while loop....
    while [ $tractcounter -le 17 ] #Number of tracts - 1. (e.g if 30 tracts, then value is 29 here due to carrying 0)
    do
	echo "The tract ${FRONTALT[(($tractcounter))]} is ${FRNUMT[(($tractcounter))]} "
	fslmaths $DIR/FS_aparc_aseg.nii.gz -thr ${FRNUMT[(($tractcounter))]} -uthr ${FRNUMT[(($tractcounter))]} $TFRONTAL/${FRONTALT[(($tractcounter))]}
        tractcounter=$((tractcounter+1)) 
    done
    
    
    
    #CINGULATE
    echo "In cingulate..."
    tractcounter=0
    declare -a CINGT=(L-RosAntCing L-CauAntCing L-PostCing L-IsthCing R-RosAntCing R-CauAntCing R-PostCing R-IsthCing)
    declare -a CGNUMT=(1026 1002 1023 1010 2026 2002 2023 2010 ) 
    
    #A do while loop....
    while [ $tractcounter -le 7 ] #Number of tracts - 1. (e.g if 30 tracts, then value is 29 here due to carrying 0)
    do
	echo "The tract ${CINGT[(($tractcounter))]} is ${CGNUMT[(($tractcounter))]} "
	fslmaths $DIR/FS_aparc_aseg.nii.gz -thr ${CGNUMT[(($tractcounter))]} -uthr ${CGNUMT[(($tractcounter))]} $TCING/${CINGT[(($tractcounter))]}
        tractcounter=$((tractcounter+1)) 
    done
    
    
    #PARIETAL
    echo "In Parietal..."
    tractcounter=0
    declare -a PARIETALT=( L-InfPar L-PreCuneus L-SupraMarg L-SupPar  R-InfPar R-PreCuneus R-SupraMarg R-SupPar)
    declare -a PRNUMT=(1008 1025 1031 1029 2008 2025 2031 2029 )
    
    
    #A do while loop....
    while [ $tractcounter -le 7 ] #Number of tracts - 1. (e.g if 30 tracts, then value is 29 here due to carrying 0)
    do
	echo "The tract ${PARIETALT[(($tractcounter))]} is ${PRNUMT[(($tractcounter))]} "
	fslmaths $DIR/FS_aparc_aseg.nii.gz -thr ${PRNUMT[(($tractcounter))]} -uthr ${PRNUMT[(($tractcounter))]} $TPARIETAL/${PARIETALT[(($tractcounter))]}
        tractcounter=$((tractcounter+1)) 
    done

    
    #OCCIPITAL
    echo "In occipital..."
    tractcounter=0
    declare -a OCCIPITALT=( L-Cuneus L-Lingual L-LatOcc R-Cuneus R-Lingual R-LatOcc)
    declare -a OCNUMT=(1005 1013 1011 2005 2013 2011) 
    
    #A do while loop....
    while [ $tractcounter -le 5 ] #Number of tracts - 1. (e.g if 30 tracts, then value is 29 here due to carrying 0)
    do
	echo "The tract ${OCCIPITALT[(($tractcounter))]} is ${OCNUMT[(($tractcounter))]} "
	fslmaths $DIR/FS_aparc_aseg.nii.gz -thr ${OCNUMT[(($tractcounter))]} -uthr ${OCNUMT[(($tractcounter))]} $TOCCIPITAL/${OCCIPITALT[(($tractcounter))]}
        tractcounter=$((tractcounter+1)) 
    done
    
    
    #TEMPORAL
    echo "In temporal..."
    tractcounter=0
    declare -a TEMPORALT=( L-ParaHipp L-MidTemp L-Entho L-InfTemp  L-Fusi  L-SupTemp L-TempPole R-ParaHipp R-MidTemp R-Entho R-InfTemp  R-Fusi R-SupTemp R-TempPole )
    declare -a TENUMT=( 1016 1015 1006 1009 1007 1030 1033  2016 2015 2006 2009 2007 2030 2033 )
    
    #A do while loop....
    while [ $tractcounter -le 13 ] #Number of tracts - 1. (e.g if 30 tracts, then value is 29 here due to carrying 0)
    do
	echo "The tract ${TEMPORALT[(($tractcounter))]} is ${TENUMT[(($tractcounter))]} "
	fslmaths $DIR/FS_aparc_aseg.nii.gz -thr ${TENUMT[(($tractcounter))]} -uthr ${TENUMT[(($tractcounter))]} $TTEMPORAL/${TEMPORALT[(($tractcounter))]}
	tractcounter=$((tractcounter+1)) 
    done
    
    #PRECENTRAL
    echo "In precentral..."
    tractcounter=0
    declare -a PRECENTRALT=( L-ParaCentral L-PreCentral R-ParaCentral R-PreCentral )
    declare -a PRENUMT=(1017 1024 2017 2024  )
    
    #A do while loop....
    while [ $tractcounter -le 3 ] #Number of tracts - 1. (e.g if 30 tracts, then value is 29 here due to carrying 0)
    do
	echo "The tract ${PRECENTRALT[(($tractcounter))]} is ${PRECENTRALT[(($tractcounter))]} "
	fslmaths $DIR/FS_aparc_aseg.nii.gz -thr ${PRENUMT[(($tractcounter))]} -uthr ${PRENUMT[(($tractcounter))]} $TPRECENTRAL/${PRECENTRALT[(($tractcounter))]}
	tractcounter=$((tractcounter+1)) 
    done
    

    #POSTCENTRAL
    
    echo "Postcentral now... "
    fslmaths $DIR/FS_aparc_aseg.nii.gz -thr 1022 -uthr 1022 $TPOSTCENTRAL/L-PostCentral
    fslmaths $DIR/FS_aparc_aseg.nii.gz -thr 2022 -uthr 2022 $TPOSTCENTRAL/R-PostCentral
   

  
    #LEFT_RIGHT HEMISPHERE EXCLUSION MASKS
    echo "Left and Right exclusion masks...."
    fslmaths $DIR/FS_aparc_aseg.nii.gz -thr 1 -uthr 39 $DIR/FS_L_brain
    fslmaths $DIR/FS_aparc_aseg.nii.gz -thr 40 -uthr 71 $DIR/FS_R_brain

done

