#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Created 10/23/2012
#Objective: 
#This script 

#PLEASE MAKE SURE YOU KNOW HOW TO USE IT BEFORE EXECUTE IT 
#IT COULD MODIFIED YOUR FILES AND THERE IS NO UNDO OF IT!

#Objective: This script will create the correct naming convention for the backup data in the KU-MED Alzheimer's Research Center.

#Any questions please feel free to contact me at the email provided above.

#MAKE SURE YOU INCLUDE drigo_renamer.sh IN YOUR PATH!!!

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
    echo "Please run the command as follow using -run:
drigo_KUADC_naming.sh -run
1. Make sure you run it from the current directory where you want to make changes!
2. Make sure drigo_renamer is in your path. 
"
    exit
fi




#############################################################################
#INPUT VALUES PART

    
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

    
echo "What is the HSC code number for the current subjects?"
read -e HSC

if [ $HSC == "11969" ]; #ADEPT PROTOCOL
then
    echo "Is is the old sequence or new sequence? (type new or old)"
    read -e ADEPTSEQ
    if [ $ADEPTSEQ == 'old' ]; then
	MPRAGE='_3.nii'
	DTI='_5.nii'
	RESTING1='_6.nii'
	RESTING2=''
	STROOP='_7.nii'
	ENCODE='_8.nii'
	RETRIEVE='_9.nii'	    
	
    elif [ $ADEPTSEQ == 'new' ] ; then
	MPRAGE='_3.nii'
	DTI='_4.nii'
	RESTING1='_10.nii'
	RESTING2=''
	STROOP='_11.nii'
	ENCODE='_12.nii'
	RETRIEVE='_13.nii'	    
	
    else
	echo "Incorrect entry. Please re-run"
	exit
    fi
elif [ $HSC == "11883" ]; then #TEAM protocol
    MPRAGE='_4.nii'
    DTI='_5.nii'
    RESTING1='_11.nii'
    RESTING2=''
    STROOP='_12.nii'
    ENCODE='_13.nii'
    RETRIEVE='_14.nii'	    
    
    
    
elif [ $HSC == "13007" ]; then #TORTIAS protocol
    MPRAGE='_2.nii'
    DTI='_12.nii'
    RESTING1='_10.nii'
    RESTING2='_11.nii'
    STROOP=''
    ENCODE='_9.nii'
    RETRIEVE=''	    
else
    echo "Incorrect protocol or not in script. Please re-run"
    exit
fi


echo "These is the default sequence number with analysis:"
echo "
	    MPRAGE --> $MPRAGE
	    DTI --> $DTI
	    RESTING1 --> $RESTING1
 	    RESTING2 --> $RESTING2
	    STROOP --> $STROOP
	    ENCODE (Pics) --> $ENCODE
	    RETRIEVE --> $RETRIEVE	
"
echo "Is this correct ?(y/n)"
read CORRECT
SQ='null'
SQN='null'

while [ $CORRECT != 'y' ] ; do
    
    if [ $CORRECT == 'n' ] ; then
	
	echo "What sequence do you want to change? (type the sequence name. e.g. MPRAGE)"
	read SQ
	echo "What number should it be?"
	read SQN
	
	
	#Changing the sequence change (SQN_ with the correspoinding one SQN)
	if [ $SQ == 'MPRAGE' ]; then
	    MPRAGE="_"$SQN".nii"
	elif [ $SQ == 'DTI' ] ; then
	    DTI="_"$SQN".nii"
	elif [ $SQ == 'RESTING1' ] ; then
	    RESTING1="_"$SQN"nii"
	elif [ $SQ == 'RESTING2' ] ; then 
	    RESTING2="_"$SQN".nii"
	    elif [ $SQ == 'STROOP' ] ; then
	    STROOP="_"$SQN".nii"
	elif [ $SQ == 'ENCODE' ] ; then
	    ENCODE="_"$SQN".nii"
	elif [ $SQ == 'RETRIEVE' ] ; then
	    RETRIEVE="_"$SQN".nii"
	fi
	
	echo "New protocol...
           MPRAGE --> $MPRAGE
	    DTI --> $DTI
	    RESTING1 --> $RESTING1
 	    RESTING2 --> $RESTING2
	    STROOP --> $STROOP
	    ENCODE --> $ENCODE
	    RETRIEVE --> $RETRIEVE  
"
	
    else
	echo "Incorrect input"
    fi
	echo "done? (y/n)"
	read CORRECT
done

drigo_renamer -rmre $MPRAGE $MPRAGE "_MPRAGE.nii" 
drigo_renamer -rmre $DTI $DTI "_DTI.nii" 
drigo_renamer -rmre $RESTING1 $RESTING1 "_RESTING1.nii" 
    drigo_renamer -rmre $RESTING2 $RESTING2 "_RESTING2.nii" 
    drigo_renamer -rmre $STROOP $STROOP "_STROOP.nii" 
    drigo_renamer -rmre $ENCODE $ENCODE "_ENCODE.nii" 
    drigo_renamer -rmre $RETRIEVE $RETRIEVE "_RETRIEVE.nii" 
    echo "Removing additional 99* sequences (orthogonal and inverse MPRAGEs)...."
    rm $HSC*_99*.nii 
    
    
########################################################################################
########################################################################################
#CODING PART TO DO CONVERSION
    








    
