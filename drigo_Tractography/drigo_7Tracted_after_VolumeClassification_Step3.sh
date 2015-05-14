#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Goal: This derives the classification targets and thresholds the data to specific connectivity values or
#       (4a Reference: PMID: 20452099 ) in regards to a constant proportion of the total number of 
#       permutations(Part 4b Reference: PMID:17499163 ) . 



#This script have several steps to collect data after tractography has been run
SOURCE=$(pwd)
CDIR=$(basename $SOURCE)

#(Variable for STEP 1-2) Tractography folder variable and output 
LTRACT="7L-Thalamus-Tract"
bigL="biggest_7L_Thalamus.nii.gz"
RTRACT="7R-Thalamus-Tract"
bigR="biggest_7R_Thalamus.nii.gz"

#(Variables for  STEP 3 and 4) Thalamus volumes
LTHALAMUS="Thalamus-L.nii.gz"
RTHALAMUS="Thalamus-R.nii.gz"


#(Variables for STEP 4) For bringing the FA/RD to
DTIFIT_FOLDER="/BRAIN/THESIS_WORK/RAW_IMAGES/ADEPT/DTIFIT_ALL"
#DTIFIT_FOLDER/BRAIN/THESIS_WORK/RAW_IMAGES/TEAM/DTIFIT_ALL
DTIBRAIN="nodif_brain.nii.gz"
#THRESHOLD=99
INT_THRESHOLD=.15 #Which is 15% of the intensity value

#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------

if [ -z $2 ] ; then
    echo -e "\nError!"
    echo -e "Please enter the prefix study (e.g. 11883*, omit the '*') as the first argument and FA or RD as the 2nd argument"
    echo -e "Error!"
    exit 1
fi


#$1 should be the directory of each folder 
for DIR in  $(ls -d $1* ) ;
do
    echo "in $DIR ... "    
    
    
#Step 4a: Generating the threshold maps after a intensity value threshold
#Steps for 4a:
# 4a.0 --> Generate a str2diff seed target (e.g. str2diff_Thalamus)
# 4a.1 --> target_to_* go from structural to diffusion space
# 4a.2 --> Calculate the maximun connectivity value 
# 4a.3 --> Threshold the data to a specific trehold of the connectivity value (usually ~15%)
# 4a.4 --> Isolate FA mask for the connected tracts...


  #    4a.0: 
   #Left Hemisphere:
    if [ ! -f $DIR/str2diff_${LTHALAMUS} ] ; then
	echo "Flirting $LTHALAMUS to diffusion space and binarizing it..."
	flirt -in $DIR/$LTHALAMUS -ref $DIR/$DTIBRAIN -applyxfm -init $DIR/xfms/str2diff.mat -out $DIR/str2diff_${LTHALAMUS}
	fslmaths $DIR/str2diff_${LTHALAMUS} -div $DIR/str2diff_${LTHALAMUS} $DIR/str2diff_${LTHALAMUS}  #making it a "binary" thalamus mask...
    fi
   #Right Hemisphere:
    
   if [ ! -f $DIR/str2diff_${RTHALAMUS} ] ; then
       echo "Flirting $RTHALAMUS to diffusion space and binarizig it..."
    flirt -in $DIR/$RTHALAMUS -ref $DIR/$DTIBRAIN -applyxfm -init $DIR/xfms/str2diff.mat -out $DIR/str2diff_${RTHALAMUS}
    fslmaths $DIR/str2diff_${RTHALAMUS} -div $DIR/str2diff_${RTHALAMUS} $DIR/str2diff_${RTHALAMUS}  #making it a "binary" thalamus mask...
   fi 
    
#Now we normalize the target_paths for each tractography by the waytotal
for TARGET in $(ls $DIR/$LTRACT/target_paths_L* ) ;
do
    TAR=$(basename $TARGET)
    echo "In $TARGET ..."
    
    #From structural to diffusion space (the target-paths in the $LTRACT folder....
    #Part 4a.0 and 4a.1
    echo "Flirting ${TAR} to diffusion space ... "
    flirt -in $DIR/$LTRACT/${TAR} -ref $DIR/$DTIBRAIN -applyxfm -init $DIR/xfms/str2diff.mat -out $DIR/$LTRACT/str2diff_${TAR}
    fslmaths $DIR/str2diff_${LTHALAMUS} -div $DIR/str2diff_${LTHALAMUS} $DIR/str2diff_${LTHALAMUS}  #making it a "binary" thalamus mask...
	
    #Part 4a.2
    MAXVALUE=$(fslstats  $DIR/$LTRACT/str2diff_${TAR} -R | awk '{print $2}')  #assigns the maximun connectivity value (from DTI space) to MAXVALUE 
    MAXVALUE=${MAXVALUE%.*} #getting rid of the decimal points.... "
    echo "Maximun connectivity value is: $MAXVALUE, thresholding at $INT_THRESHOLD ..."
    cc(){ awk "BEGIN{ print $* }" ;} #added a function for cc so I can multiple variables...
    TRER=$( cc $MAXVALUE*$INT_THRESHOLD) #dealing with multiplying the threshold...
    
    
	#Part 4a.3
    echo  "Tresholding... "
    fslmaths $DIR/$LTRACT/str2diff_${TAR} -thr $TRER  $DIR/$LTRACT/tr${INT_THRESHOLD}perc_str2diff_${TAR}  #tresholding using fslmaths


	#Part 4a.4
	echo  "Isolating the FA/RD values from the path.... "
	fslmaths  $DIR/$LTRACT/tr${INT_THRESHOLD}perc_str2diff_${TAR}  -div $DIR/$LTRACT/tr${INT_THRESHOLD}perc_str2diff_${TAR}  -mul $DIR/${DIR/.bedpostX/_${2}.nii.gz} $DIR/$LTRACT/${2}_tr${INT_THRESHOLD}perc_str2diff_${TAR} 
	
    done


#NOW THE RIGHT HEMISPHERE....

#Now we normalize the target_paths for each tractography by the waytotal
    for TARGET in $(ls $DIR/$RTRACT/target_paths_R* ) ;
    do
	TAR=$(basename $TARGET)
	echo "In $TARGET ..."
	
        #From structural to diffusion space....
	#Part 4a.0 and 4a.1
	echo "Flirting ${TAR} to diffiusion space ... "
	flirt -in $DIR/$RTRACT/${TAR} -ref $DIR/$DTIBRAIN -applyxfm -init $DIR/xfms/str2diff.mat -out $DIR/$RTRACT/str2diff_${TAR}
	
	#Part 4a.2
	MAXVALUE=$(fslstats  $DIR/$RTRACT/str2diff_${TAR} -R | awk '{print $2}')  #assigns the maximun connectivity value (from DTI space) to MAXVALUE
	MAXVALUE=${MAXVALUE%.*} #getting rid of the decimal points....
	echo "Maximun connectivity value is: $MAXVALUE , thresholding at $INT_THRESHOLD ..."
	cc(){ awk "BEGIN{ print $* }" ;} #added a function for cc so I can multiple variables...
	TRER=$( cc $MAXVALUE*$INT_THRESHOLD) #dealing with multiplying the threshold...
	
	
	#Part 4a.3
	echo  "Tresholding... "
	fslmaths $DIR/$RTRACT/str2diff_${TAR} -thr $TRER  $DIR/$RTRACT/tr${INT_THRESHOLD}perc_str2diff_${TAR}  #tresholding using fslmaths
	
	
	#Part 4a.4
	echo  "Isolating the FA/RD values from the path...."
	fslmaths  $DIR/$RTRACT/tr${INT_THRESHOLD}perc_str2diff_${TAR}  -div  $DIR/$RTRACT/tr${INT_THRESHOLD}perc_str2diff_${TAR}  -mul $DIR/${DIR/.bedpostX/_${2}.nii.gz} $DIR/$RTRACT/${2}_tr${INT_THRESHOLD}perc_str2diff_${TAR}
	
    done
done

