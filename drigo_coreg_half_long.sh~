#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#PLEASE ADD DESCRIPTION HERE:!!!!!!
#
#
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.


SOURCE=$( pwd )

#Checking what you are doing.....
if  [ $1 = "--help" ] ; then
    echo "to run tiInstructions enter here...."
    exit
fi

################################################

#PROJECT ID BASENAME 
#Assigning the foldername to $FOLDER
IMAGE=$1

echo "What project id are you using(e.g. 11969 will be default if you hit enter)?"
read -e PROJECTID
echo "How is the timepoint annotated?  (e.g. 11969_XXX_"01". Enter for default: 01 )?"
read -e TIMEPOINT
echo "Second timepoint? (e.g. 02? 03? Enter will be 03)"
read -e TIME2

echo "DTI measurement? (e.g. FA, hit enter if using FA)"
read -e DTIMES


#If LOCATION is a null string...allocated as the pwd directory....

if [ -z $PROJECTID ]; then
    PROJECTID='11969'
fi
if [ -z $TIMEPOINT  ]; then
    TIMEPOINT='01'
fi
if [ -z $TIME2 ] ; then
    TIME2='03'
fi

if [ -z $DTIMES ] ; then
	DTIMES='FA'
fi



for FILE in $(ls ${PROJECTID}_*_${TIMEPOINT}*_${DTIMES}.nii.gz );
do
    echo $FILE
    BASENAME=${FILE//_${TIMEPOINT}_*}
    echo "In $BASENAME..."
    
    
    #CCalculating the registration of Timepoint2 to Timepoint1
    flirt -in ${FILE/_${TIMEPOINT}_/_${TIME2}_} -ref $FILE -omat ${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat
    
    #Calculating the midpoint tranformations....
    midtrans --separate=${BASENAME}_XX  -o ${BASENAME}_${TIMEPOINT}_to_Mid.mat  ${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat $FSLDIR/etc/flirtsch/ident.mat

    #Half-way registration to Time1. We use trilinear for avoiding negative FA values....
    flirt -in $FILE -ref ${FILE/_${TIMEPOINT}_/_${TIME2}_} -applyxfm -init  ${BASENAME}_${TIMEPOINT}_to_Mid.mat  -o coreg_${FILE} -interp trilinear
    flirt -in ${FILE/_${TIMEPOINT}_/_${TIME2}_} -ref $FILE -applyxfm -init  ${BASENAME}_XX0001.mat -o coreg_${FILE/_${TIMEPOINT}_/_${TIME2}_} -interp trilinear

done





###OLD 2nd TRY

	#Calculating the registration of Timepoint1 to Timepoint2
 #   flirt -in $FILE -ref ${FILE/_${TIMEPOINT}_/_${TIME2}_} -omat ${BASENAME}__${TIMEPOINT}_to_${TIME2}.mat
    
	#Calculating the registration of Timepoint2 to Timepoint1
 #   flirt -in ${FILE/_${TIMEPOINT}_/_${TIME2}_} -ref $FILE -omat ${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat
	#Inverting the registration Timepoint2 to Timepoint1
 #   convert_xfm -omat inv_${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat -inverse ${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat
   
	#Generate a mid_point matrix with information between the invT2_to_T1 and T1_to_T2
 #   midtrans -o refined_${BASENAME}_${TIMEPOINT}_to_$TIME2.mat  inv_${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat ${BASENAME}__${TIMEPOINT}_to_${TIME2}.mat 
    
	#Generating the XX midpoint transforms for every timepoint
#    midtrans --separate=${BASENAME}_XX -o ${BASENAME}__${TIME2}_to_MID.mat  refined_${BASENAME}_${TIMEPOINT}_to_$TIME2.mat $FSLDIR/etc/flirtsch/ident.mat
    
	#Registrations

#    echo "Coregistering Timepoint1 to Timepoint2...."
#    flirt -in $FILE -ref ${FILE/_${TIMEPOINT}_/_${TIME2}_}  -applyxfm -init ${BASENAME}_XX0001.mat -o coreg_half_${FILE} -interp spline
#    echo "Coregistering Timepoint2 to Timepoint1...."
#    flirt -in ${FILE/_${TIMEPOINT}_/_${TIME2}_} -ref $FILE  -applyxfm -init ${BASENAME}_XX0002.mat -o coreg_half_${FILE/_${TIMEPOINT}_/_${TIME2}_}  -interp spline 



###OLDER TRY

	#Calculating the registration of Timepoint1 to Timepoint2
#    flirt -in $FILE -ref ${FILE/_${TIMEPOINT}_/_${TIME2}_} -omat ${BASENAME}__${TIMEPOINT}_to_${TIME2}.mat
    
	#Calculating the registration of Timepoint2 to Timepoint1
#    flirt -in ${FILE/_${TIMEPOINT}_/_${TIME2}_} -ref $FILE -omat ${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat
	#Inverting the registration Timepoint2 to Timepoint1
#    convert_xfm -omat inv_${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat -inverse ${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat
   
	#Generate a mid_point matrix with information between the invT2_to_T1 and T1_to_T2
#    midtrans -o refined_${BASENAME}_${TIMEPOINT}_to_$TIME2.mat  inv_${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat  ${BASENAME}__${TIME2}_to_${TIMEPOINT}.mat #${BASENAME}__${TIMEPOINT}_to_${TIME2}.mat 
    
	#Generating the XX midpoint transforms for every timepoint
#    midtrans --separate=${BASENAME}_XX -o ${BASENAME}__${TIME2}_to_MID.mat  refined_${BASENAME}_${TIMEPOINT}_to_$TIME2.mat $FSLDIR/etc/flirtsch/ident.mat
    
	#Registrations

#    echo "Coregistering Timepoint1 to Timepoint2...."
#    flirt -in $FILE -ref ${FILE/_${TIMEPOINT}_/_${TIME2}_}  -applyxfm -init ${BASENAME}_XX0001.mat -o coreg_half_${FILE} -interp spline
#    echo "Coregistering Timepoint2 to Timepoint1...."
#    flirt -in ${FILE/_${TIMEPOINT}_/_${TIME2}_} -ref $FILE  -applyxfm -init ${BASENAME}_XX0002.mat -o coreg_half_${FILE/_${TIMEPOINT}_/_${TIME2}_}  -interp spline 

#done
