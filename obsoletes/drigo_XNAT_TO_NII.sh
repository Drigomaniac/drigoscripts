#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Created 10/23/2012
#Objective: 
#This script 

#PLEASE MAKE SURE YOU KNOW HOW TO USE IT BEFORE EXECUTE IT ````
#IT COULD MODIFIED YOUR FILES AND THERE IS NO UNDO OF IT!

#Objective: This script will get data from XNAT in dicom format and convert it to NIFTII in a 
#better more readable way for the user to submitt jobs to the cluster and to have an organized
#data in NIFTII format in the Alzheimer' Research Program at KU-MED
#Any questions please feel free to contact me at the email provided above.


#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#HERE IS AN EXAMPLE INPUT:
SOURCE=$( pwd )

if [ -z $1 ] ; 
then
    echo "
Run drigo_XNAT_TO_CLUSTER.sh --help for help"

exit

fi


#Help instruction....to be filled
if [ $1 == "--help" ] ; then
    echo "checking drigo_RAW_to_nii.sh help command .....
This script will change either a *.dcm *.ima *DCM files into a parent folder directory and convert it into niftii -format.
Run drigo_RAW_to_nii -showexample for example data. Make sure you delete other non-data subdirectories such as SNAPSHOTS....

"
    exit
fi




#############################################################################
#INPUT VALUES PART

confirmation="n"
while [ $confirmation != "y" ] ;
do
    
#Initializing variables...
  #  TESTING INPUTS>>>>>  
  #  plusIMG="y"
  #  PARPRE="sa"
  #  SPARPRE="sa23017/scans/"
  #  FOLDERTREE="sa23017/scans/2-MPRAGE/resources/DICOM/files/RAW/"
  #  confirmation="y"
plusIMG="null"
PARDIR="null"
FOLDERTREE="null"
SPARDIR="null"

    
    echo "What is the prefix (e.g. HSC code number, 11969) for the current subjects?"
    read -e PARPRE
       

    echo "What is the DICOM file full path directory tree? (e.g. 11969_001_01/scans/3/DICOM/ )"
    read -e FOLDERTREE
    
    echo "Where could we find more than one DICOM images for each subdirectory? (e.g. 11969_001_01/scans/ )"
    read -e SPARPRE
    

    
    echo "
The following values will be used:
Parent prefix: $PARPRE*
Folder tree: $FOLDERTREE
Path where more DICOM images could be: $SPARPRE
NOTE: Delete other subfolder trees where no dicom files are located (e.g. SNAPSHOTS)

Is the information above correct (y/n) ?"
read confirmation 
done



########################################################################################
########################################################################################
#CODING PART TO CONVERT DICOM TO NIFTIIII
    
echo "

In parent directory $BASEDIR"
    #Counting the number of slashes to check how many directy trees we have...
CSLASH=$( echo $FOLDERTREE | grep -o "\/" | wc -l )
CSUBSLASH=$( echo $SPARPRE | grep -o "\/" | wc -l )

    #TO SUBSTRACT A VALUE IN THEM (since BASH in untyped...)
COUNTER=$(( $CSLASH - $CSUBSLASH - 1   ))


     #Adding the "*/" character as many times needed....
POSTSLASH=$( for((i=1;i<=$(($COUNTER));i++));do printf "%s" "*/";done;printf "\n" )
PRESLASH=$( for((i=1;i<=$(( $CSUBSLASH));i++));do printf "%s" "*/";done;printf "\n" )
SLASH=$( for((i=1;i<=$(($CSLASH));i++));do printf "%s" "*/";done;printf "\n" )

    #Entering the base directory where I'll be working
for SUBASEDIR in $( ls -d $PARPRE*/$PRESLASH );
do

#Initializing variables again so we dont overlap the names of previous files..."
BNAME='null'  
BASENAME='null' 
FIRSTFILE='null' 


    echo "
In subparent directory... $SUBASEDIR "
    BNAME=$( basename $SUBASEDIR )
    
    BASENAME=${SUBASEDIR///*}
    #Retrieving one single file....
    for FILE in $( ls  $SUBASEDIR$POSTSLASH/*  ) ; do FIRSTFILE=$FILE; done
    echo "in $SUBASEDIR$POSTSLASH"
    echo "mri_convert $FIRSTFILE $BASENAME"_"$BNAME.nii"
    #  This has been modified to use dcm2nii instead of mri_convert due to errors with bvals and bvecs in DTI.... 
    #    mri_convert $FIRSTFILE $BASENAME"_"$BNAME.nii
    ALLDIR=$SUBASEDIR'DICOM'
    dcm2nii -g n $ALLDIR 

    #Now we are checking at the output of dcm2nii. This will avoid problems with creating more than one file in each DICOM directory....
    i=991
    echo "ALLDIR is $ALLDIR"
    for eachNII in  $ALLDIR/*.nii ; do
	echo " i is $i"
	if [ $i == "991" ] ; then
	    mv $eachNII $SOURCE/$BASENAME"_"$BNAME.nii
	    i=$i+1
	else
	    mv $eachNII $SOURCE/$BASENAME"_"$BNAME"_$((i++))".nii
            i=$((i++))
	fi
	    echo $eachNII
    done
    #End of mv and avoiding dcm2nii output. 
     
#For your own reference in each loop the variables are:
    
#FIRSTFILE = /11883_127_01/scans/4/DICOM/<weirdname>.dcm
#BASENAME = /11883_127_01
#BNAME = 4
#SUBASEDIR = /11883_127_01/scans/4/

done
echo "




"

ls







    
