#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)

#Step 4. Creating 7 tracts


#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.

#!!!!!
#---> This script might not work if slight modifications are not given due
#     to folder specific locations...

#!!!!!



SOURCE=$(pwd)
CDIR=$(basename $SOURCE)



if [ $1 -eq "--help" ] ;then
echo " 
This Script does the following:
	1. Add the Targets/Frontal/mask_L* to \$TEMP
	2. Copy \$TEMP to L-Frontal.nii.gz 
	3. Iterates 1 and 2 for all the 7 segementations
	Outputs: \$Targets/L-*.nii.gz \$Targets/R-*.nii.gz 
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
    echo "In directory $DIR with basename $DIRtemp"
    TARGETS=$DIR/Targets
    TFRONTAL=$TARGETS/Frontal
    TCING=$TARGETS/Cingulate
    TPARIETAL=$TARGETS/Parietal
    TOCCIPITAL=$TARGETS/Occipital
    TTEMPORAL=$TARGETS/Temporal
    TPRECENTRAL=$TARGETS/PreCentral
    TPOSTCENTRAL=$TARGETS/PostCentral
    TEMP=$DIR/temp.nii.gz

   
    #FRONTAL
    echo "frontal..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    
    for FILE in $(ls $SOURCE/$TFRONTAL/mask_L* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/L-Frontal.nii.gz
    rm $TEMP
    echo " "
    

  
    #CINGULATE
    echo "cingulate"
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TCING/mask_L* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/L-Cingulate.nii.gz
    rm $TEMP
    echo " "


    #PARIETAL
    echo "parietal..."
   fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TPARIETAL/mask_L* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/L-Parietal.nii.gz
    rm $TEMP
    echo " "

    #OCCIPITAL
    echo "occipital..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TOCCIPITAL/mask_L* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
   cp $TEMP $TARGETS/L-Occipital.nii.gz
    rm $TEMP
    echo " "

    #TEMPORAL
    echo "temporal..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TTEMPORAL/mask_L* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/L-Temporal.nii.gz
    rm $TEMP
    echo " "

    #PRECENTRAL
    echo "precentral..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TPRECENTRAL/mask_L* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/L-Precentral.nii.gz
    rm $TEMP
    echo " "

    #POSTCENTRAL
     echo "postcentral..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TPOSTCENTRAL/mask_L* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/L-PostCentral.nii.gz
    rm $TEMP
    echo " "

       #FRONTAL
    echo "frontal..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    
    for FILE in $(ls $SOURCE/$TFRONTAL/mask_R* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/R-Frontal.nii.gz
    rm $TEMP
    echo " "
    

  
    #CINGULATE
    echo "cingulate"
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TCING/mask_R* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/R-Cingulate.nii.gz
    rm $TEMP
    echo " "


    #PARIETAL
    echo "parietal..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TPARIETAL/mask_R* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/R-Parietal.nii.gz
    rm $TEMP
    echo " "

    #OCCIPITAL
    echo "occipital..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TOCCIPITAL/mask_R* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/R-Occipital.nii.gz
    rm $TEMP
    echo " "

    #TEMPORAL
    echo "temporal..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TTEMPORAL/mask_R* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/R-Temporal.nii.gz
    rm $TEMP
    echo " "

    #PRECENTRAL
    echo "precentral..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TPRECENTRAL/mask_R* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
   cp $TEMP $TARGETS/R-Precentral.nii.gz
    rm $TEMP
    echo " "

    #POSTCENTRAL
     echo "postcentral..."
    fslmaths $DIR/FS_brain -sub $DIR/FS_brain $TEMP
    for FILE in $(ls $SOURCE/$TPOSTCENTRAL/mask_R* ); 
    do
	echo "$FILE..."
	fslmaths $TEMP -add $FILE $TEMP
    done
    cp $TEMP $TARGETS/R-PostCentral.nii.gz
    rm $TEMP
    echo " "

done

