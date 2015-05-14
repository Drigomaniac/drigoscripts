#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)

#Step 3. Masking the parcellations and creating 7Tract Masks
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.

#!!!!!
#---> This script might not work if slight modifications are not given due
#     to folder specific locations...

#!!!!!



SOURCE=$(pwd)
CDIR=$(basename $SOURCE)


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


    #FRONTAL
    for FILE in $(ls $SOURCE/$TFRONTAL ); 
    do
	echo "$FILE..."
	fslmaths $TFRONTAL/$FILE -div $TFRONTAL/$FILE $TFRONTAL/mask_${FILE}
	
    done
    echo " "
    
    #CINGULATE
    for FILE in $(ls $SOURCE/$TCING ); 
    do
	echo "$FILE..."
	fslmaths $TCING/$FILE -div $TCING/$FILE $TCING/mask_${FILE}
    done
    
    echo " " 
	
    #PARIETAL
    for FILE in $(ls $SOURCE/$TPARIETAL ); 
    do
	echo "$FILE..."
	fslmaths $TPARIETAL/$FILE -div $TPARIETAL/$FILE $TPARIETAL/mask_${FILE}
    done
      echo " " 


    #OCCIPITAL
    for FILE in $(ls $SOURCE/$TOCCIPITAL ); 
    do
	echo "$FILE..."
	fslmaths $TOCCIPITAL/$FILE -div $TOCCIPITAL/$FILE $TOCCIPITAL/mask_${FILE}
	
    done
    echo " " 


    #TEMPORAL
    for FILE in $(ls $SOURCE/$TTEMPORAL ); 
    do
	echo "$FILE..."
	fslmaths $TTEMPORAL/$FILE -div $TTEMPORAL/$FILE $TTEMPORAL/mask_${FILE}
	
    done
    echo " " 


    #PRECENTRAL
    for FILE in $(ls $SOURCE/$TPRECENTRAL ); 
    do
	echo "$FILE..."
	fslmaths $TPRECENTRAL/$FILE -div $TPRECENTRAL/$FILE $TPRECENTRAL/mask_${FILE}
	
    done
    echo " " 

    #POSTCENTRAL
    for FILE in $(ls $SOURCE/$TPOSTCENTRAL ); 
    do
	echo "$FILE..."
	fslmaths $TPOSTCENTRAL/$FILE -div $TPOSTCENTRAL/$FILE $TPOSTCENTRAL/mask_${FILE}
	
    done
    echo " " 
done

