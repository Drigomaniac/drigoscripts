#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)

#This script have several steps to collect data after tractography has been run
SOURCE=$(pwd)
CDIR=$(basename $SOURCE)

#(FOR STEP 1-2) Tractography folder variable and output 
LTRACT="7L-Thalamus-Tract"
bigL="biggest_7L_Thalamus.nii.gz"
RTRACT="7R-Thalamus-Tract"
bigR="biggest_7R_Thalamus.nii.gz"

#(FOR STEP 3) Thalamus volumes
LTHALAMUS="Thalamus-L.nii.gz"
RTHALAMUS="Thalamus-R.nii.gz"


#(FOR STEP 4) For bringing the FA/RD to
DTIFIT_FOLDER="/BRAIN/THESIS_WORK/RAW_IMAGES/ADEPT/DTIFIT_ALL"
#DTIFIT_FOLDER/BRAIN/THESIS_WORK/RAW_IMAGES/TEAM/DTIFIT_ALL
DTIBRAIN="nodif_brain.nii.gz"
THRESHOLD=99


#(FOR STEP5) Generate the FA/RD mean values and voxels
TEMP5="temp5.nii.gz"
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------




if [ -z $@ ] ; then
    echo -e "\n Error!"
    echo -e "Please enter the prefix study (e.g. 11883*, omit the '*') as the first argument \n "
    exit 1
fi


for DIR in  $(ls -d $1* ) ;
do
    
#Step 1, create the classification targets with find_the_biggest
#echo "In $DIR..." 
#find_the_biggest $DIR/7L-Thalamus-Tract/seeds_to_L-* $DIR/$LTRACT/$bigL 
#find_the_biggest $DIR/7R-Thalamus-Tract/seeds_to_R-* $DIR/$RTRACT/$bigR ;

#OUTPUT FOR 7 Tract:

#  number of inputs 7
#  Indices
#  0 ---> Contains all non-zero voxels
#  1 13007_014_02.bedpostX/7L-Thalamus-Tract/seeds_to_L-Cingulate.nii.gz
#  2 13007_014_02.bedpostX/7L-Thalamus-Tract/seeds_to_L-Frontal.nii.gz
#  3 13007_014_02.bedpostX/7L-Thalamus-Tract/seeds_to_L-Occipital.nii.gz
#  4 13007_014_02.bedpostX/7L-Thalamus-Tract/seeds_to_L-Parietal.nii.gz
#  5 13007_014_02.bedpostX/7L-Thalamus-Tract/seeds_to_L-PostCentral.nii.gz
#  6 13007_014_02.bedpostX/7L-Thalamus-Tract/seeds_to_L-Precentral.nii.gz
#  7 13007_014_02.bedpostX/7L-Thalamus-Tract/seeds_to_L-Temporal.nii.gz
#-----------------------------------------------------------------------------------------------------------




#Step 2: Volume of classifications
#echo "${DIR} Left"
#fslstats $DIR/$LTRACT/$bigL -H 8 0 7
    
#echo "${DIR} Right"
#fslstats $DIR/$RTRACT/$bigR -H 8 0 7
#-----------------------------------------------------------------------------------------------------------


#Step 3: Thalamus Volumes
#if [[ $DIR != *$2* ]]
#then
#    echo $DIR
#fi
#fslstats $DIR/$LTHALAMUS -V | awk '{print $1}'
#fslstats $DIR/$RTHALAMUS -V | awk '{print $1}'
#-----------------------------------------------------------------------------------------------------------



#Step 4: Working with the paths and generating a $TRESHOLD (e.g. 95th) thresholded and DTI space masks (to be applied in DTI
#        values
#-----------------------------------------------------------------------------------------------------------
    
#Copying FA/RD
#echo "Copying FA/RD in $DIR ..."
#cp $DTIFIT_FOLDER/${DIR//.bedpostX}*FA* $DIR/
#cp $DTIFIT_FOLDER/${DIR//.bedpostX}*RD* $DIR/
    
    
#Getting Waytotal values for each segmentation
    WAYL=$( cat $DIR/$LTRACT/waytotal )
    WAYR=$( cat $DIR/$RTRACT/waytotal )
    
#Now we normalize the target_paths for each tractography by the waytotal
  #  for TARGET in $(ls $DIR/$LTRACT/target_paths_L* ) ;
  #  do
	#TAR=$(basename $TARGET)
	#echo "In $TARGET ..."
	#echo "Normalizing..."
	#fslmaths $TARGET -div $WAYL $DIR/$LTRACT/norm_${TAR}
	#echo "From structural to diffusion space..."
	#flirt -in $DIR/$LTRACT/norm_${TAR} -ref $DIR/$DTIBRAIN -applyxfm -init $DIR/xfms/str2diff.mat -out $DIR/$LTRACT/str2diff_norm_${TAR}
	#echo -e "Tresholding the DTI paths to the ${THRESHOLD}th percentile only... \n"
	#fslmaths  $DIR/$LTRACT/str2diff_norm_${TAR} -thrP $THRESHOLD  $DIR/$LTRACT/tr${THRESHOLD}_str2diff_norm_${TAR}
	
    #done


#NOW THE RIGHT HEMISPHERE....

     #   for TARGET in $(ls $DIR/$RTRACT/target_paths_R* ) ;
    #do
	#TAR=$(basename $TARGET)
	#echo "In $TARGET ..."
	#echo "Normalizing..."
	#fslmaths $TARGET -div $WAYR $DIR/$RTRACT/norm_${TAR}
	#echo "From structural to diffusion space..."
	#flirt -in $DIR/$RTRACT/norm_${TAR} -ref $DIR/$DTIBRAIN -applyxfm -init $DIR/xfms/str2diff.mat -out $DIR/$RTRACT/str2diff_norm_${TAR}
	#echo -e "Tresholding the DTI paths to the 95th percentile only... \n"
	#fslmaths  $DIR/$RTRACT/str2diff_norm_${TAR} -thrP $THRESHOLD  $DIR/$RTRACT/tr${THRESHOLD}_str2diff_norm_${TAR}
	
    #done


#Step 5: Using the tr$THRESHOLD_str2diff_norm_${TAR} masks (from Step 4) to generate the mean FA/RD values and 
    # volumes

    if [[ $DIR == *_01.* ]]
    then
	echo $DIR
    fi 
     
    
   # for FILE in $(ls $DIR/$LTRACT/tr${THRESHOLD}* ) ; 
   # do
#	FILEBASE=$(basename $FILE)

#	fslmaths $FILE -div $FILE $DIR/$LTRACT/$TEMP5
#	fslmaths $DIR/${DIR/.bedpostX/_FA.nii.gz} -mul $DIR/$LTRACT/$TEMP5 $DIR/$LTRACT/FA_$FILEBASE
#	fslstats $DIR/$LTRACT/FA_$FILEBASE -M
#	fslstats $DIR/$LTRACT/FA_$FILEBASE -V | awk '{print $1}'
#	rm $DIR/$LTRACT/$TEMP5
#    done
    
       for FILE in $(ls $DIR/$RTRACT/tr${THRESHOLD}* ) ; 
    do
	FILEBASE=$(basename $FILE)

	fslmaths $FILE -div $FILE $DIR/$RTRACT/$TEMP5
	fslmaths $DIR/${DIR/.bedpostX/_FA.nii.gz} -mul $DIR/$RTRACT/$TEMP5 $DIR/$RTRACT/FA_$FILEBASE
	fslstats $DIR/$RTRACT/FA_$FILEBASE -M
	fslstats $DIR/$RTRACT/FA_$FILEBASE -V | awk '{print $1}'
	rm $DIR/$RTRACT/$TEMP5
    done
     

done

