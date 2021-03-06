#!/bin/bash
#Rodrigo Perea
#Goal: This script should be executed after PROBTRACKX2 has been executed
# It will generate copy the necessary files
# to create a str2diff tranformations of the paths and generate the paths
# in diffusion space. 

 



SOURCE=$( pwd )
#Variables to initialize
TARGET=$1
LDIR="L_str2diff_TARGETS"
mkdir -p $SOURCE/$LDIR

for DIR in $(ls -1d $SOURCE/11969_* ) ; 
do
    DIRB=$(basename $DIR)

#FROM STEP1
#    #Copying the neccesary files
#    echo "Copying in $DIR..."
#    mkdir -p $LDIR/$DIRB
#    cp $DIR/xfms/str2diff.mat $LDIR/$DIRB/
#    cp $DIR/L-Thalamus-Tract/waytotal $LDIR/$DIRB/L-waytotal
#    cp $DIR/L-Thalamus-Tract/target* $LDIR/$DIRB/
#    cp $DIR/R-Thalamus-Tract/waytotal $LDIR/$DIRB/R-waytotal
#    cp $DIR/R-Thalamus-Tract/target* $LDIR/$DIRB/
#    cp $DIR/nodif_brain.nii.gz $LDIR/$DIRB/
#    cp $DIR/FS_brain.nii.gz $LDIR/$DIRB/
 
    WAYTOTAL=1
    WAYL=$(cat $DIR/waytotal-L)
    WAYR=$(cat $DIR/waytotal-R)
    echo "In $DIR ... "
    #Entering each directory ....
    cd $DIR
    for TAR in $(ls target_paths_R* ) ;
    do
	echo "In $TAR ... "

	fslmaths $TAR -div $WAYL norm_${TAR}
	flirt -in norm_${TAR} -ref nodif_brain.nii.gz -applyxfm -init str2diff.mat -out str2diff_norm_${TAR}
	fslmaths str2diff_norm_${TAR} -thrP 95 tr95_str2diff_norm_${TAR}

    done
    cd $SOURCE
    #leaving each directory....
done


