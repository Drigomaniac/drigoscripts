#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Created 03/25/2015
#Objective: 
#This script 

#PLEASE MAKE SURE YOU KNOW HOW TO USE IT BEFORE EXECUTE IT 
#IT COULD MODIFIED YOUR FILES AND THERE IS NO UNDO OF IT!

#Objective: This script will output the values of each specific FreeSurfer segmentation using the asegstats2table script from fsl given a list of subject folders.

#Any questions please feel free to contact me at the email provided above.

#MAKE SURE YOU INCLUDE the necessary dependent FreeSurfer files/binaries.

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#HERE IS AN EXAMPLE INPUT:

SOURCE=$( pwd )
if [ -z $1 ] ; 
then
    echo "
Run drigo_FS_Volumes.sh --help for help"

exit

fi


#Help instruction....to be filled
if [ $1 == "--help" ] ; then
    echo "Please run the command with the followin command:
drigo_FS_Volumes.sh -runok
1. Make sure you run it from the current directory where you want to make changes!
2. Modify the file!! Open it, and change the array VOLUME with the volume regions you want to include at line 44
"
    exit
fi

#############################################################################
#Declaring the VOLUMES array!!!!
declare -a VOLUME=( 2 41 17 53 219 702 703 )
#Region volumes are shown in http://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/AnatomicalROI/FreeSurferColorLUT 
#The following are give:
# 2 --> Left-Cerebral-White-Matter 
# 41--> Right-Cerebral-White-Matter 
# 17 --> L-Hippo
# 53 --> R-Hippo
# 219 --> Cerebral_White_Matter
# 702 --> GrayMatter-FSL-FAST                     
# 703 --> WhiteMatter-FSL-FAST 
#############################################################################    


if [ $1 == "-runok" ]; then
    
    echo "What is the prefix of the file (e.g. WU_*, then type WU_.  For WU_ hit enter) ?"
    read -e PRE
    
    echo "What directoy contains all the segmentations (e.g. FS Folder? If working directory, hit enter)?"
    read -e CDIREC
    
    echo "Name of the stats table?"
    read NAME

    if [ $CDIREC -z ] ; then
	CDIREC=$SOURCE
    fi
    
    if [ $PRE -z ] ; then
	PRE="WU_"
    fi

 
    
    ls -1 -d $CDIREC/PREFIX* >> temp.txt
    
    
    echo "Prefix for the files is: $PRE"
    asegstats2table --subjectsfile=temp.txt --tablefile $NAME
    
    
    
fi

    








    
