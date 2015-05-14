#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Created 10/23/2012
#Objective: 
#This script 

#PLEASE MAKE SURE YOU KNOW HOW TO USE IT BEFORE EXECUTE IT 
#IT COULD MODIFIED YOUR FILES AND THERE IS NO UNDO OF IT!

#Any questions please feel free to contact me at the email provided above.


#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#HERE IS AN EXAMPLE INPUT:


if [ -z $1 ] ; 
then
    echo "Run drigo_RAW_to_nii -run to run
Run drigo_RAW_to_nii --help for helpn
Run drigo_RAW_to_nii -showexample to look at input examples "
exit

fi


if [ $1 == "-showexample" ] ;
then
    echo "

###################EXAMPLE BEGINS ##############################################
rperea@kum-rhonea2:/BRAIN/ADRC_Sessions/TEST$ drigo_RAW_to_nii.sh -run
What is the prefix of the parent directories? 
##INPUT ---> 11

What is the dicom file full path directory?
110
110105_TC32822/  110124_CC32883/  110215_TC33013/  110321_CC33229/  110412_TC33358/  110525_TC33654/  110708_TC33875/  110729_TC34000/  110829_TC34169/
110106_TC32824/  110125_CC32996/  110218_TC32912/  110323_TC33203/  110415_TC33366/  110526_TC33655/  110713_TC33905/  110802_TC34026/  110830_TC34170/
.
.
.
##INPUT ---> 110105_TC32822/scans/4-MPRAGE/resources/DICOM/files/

Where is the subdirectories will we contain more than one image session?
##INPUT ---> 110105_TC32822/scans/

The following values will be used:
Parent prefix: 11*
Folder tree: 110105_TC32822/scans/4-MPRAGE/resources/DICOM/files/
Subdirectory parent: 110105_TC32822/scans/
NOTE: Delete other subfolder trees where no dicom files are located (e.g. SNAPSHOTS)

Is the information above correct (y/n) ?
y

###############################EXAMPLE ENDS#####################################
"
exit
fi
#################################################################################




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

    
    echo "What is the prefix of the parent directories? "
    read -e PARPRE
    
    

    echo "What is the DICOM file full path directory tree?"
   read -e FOLDERTREE

    
	echo "Where could we find more than one DICOM images for each subdirectory?"
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
#CODING PART
    
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
	    #echo "$SLASH"
	    #Retrieving one single file....
    for FILE in $( ls  $SUBASEDIR$POSTSLASH/*  ) ; do FIRSTFILE=$FILE; done
#	    echo "in $SUBASEDIR$POSTSLASH"
    echo "mri_convert $FIRSTFILE $BASENAME"_"$BNAME.nii"
    
echo "    mri_convert $FIRSTFILE $BASENAME"_"$BNAME.nii"
    
    
    
done




    
