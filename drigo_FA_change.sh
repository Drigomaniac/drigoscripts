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
    echo "Instructions enter here:
    This script grabs the vol00*.nii.gz from all_FA.nii.gz and applied a normalized FA_change from vol0 and vol1
    You need a subjectnamelist.txt file containing the name of the files (usually from ../origdata/*) in ascending order
"
    exit
fi


counter=0
long_flag=0
declare -a ARRAY=( coreg_11883_087_01_FA_FAdeformed.nii.gz  coreg_11883_087_02_FA_FAdeformed.nii.gz  coreg_11883_089_01_FA_FAdeformed.nii.gz  coreg_11883_089_02_FA_FAdeformed.nii.gz  coreg_11883_090_01_FA_FAdeformed.nii.gz  coreg_11883_090_02_FA_FAdeformed.nii.gz  coreg_11883_092_01_FA_FAdeformed.nii.gz  coreg_11883_092_02_FA_FAdeformed.nii.gz  coreg_11883_093_01_FA_FAdeformed.nii.gz  coreg_11883_093_02_FA_FAdeformed.nii.gz  coreg_11883_099_01_FA_FAdeformed.nii.gz  coreg_11883_099_02_FA_FAdeformed.nii.gz  coreg_11883_116_01_FA_FAdeformed.nii.gz  coreg_11883_116_02_FA_FAdeformed.nii.gz  coreg_11883_118_01_FA_FAdeformed.nii.gz  coreg_11883_118_02_FA_FAdeformed.nii.gz  coreg_11883_122_01_FA_FAdeformed.nii.gz  coreg_11883_122_02_FA_FAdeformed.nii.gz  coreg_11883_126_01_FA_FAdeformed.nii.gz  coreg_11883_126_02_FA_FAdeformed.nii.gz  coreg_11883_127_01_FA_FAdeformed.nii.gz  coreg_11883_127_02_FA_FAdeformed.nii.gz )


for FILE in $(ls vol* ); 
do
echo "Copying.. $FILE to ${ARRAY[ $counter ]}"
cp $FILE ${ARRAY[ $counter ]}
counter=$(($counter+1))
done


#Check for the array length...
ARRLENGTH=${#ARRAY[@]}
echo "Array length is $ARRLENGTH"



counter=0
#for loop to run sequentially 
for i in $(seq 1 $ARRLENGTH)
do
    counter=$(($counter+1))

    #initialize the vairable that will be used for the FA_name change
    FACHANGE=${ARRAY[ $counter -1 ]}
    FACHANGE=${FACHANGE//_01_FA_FA.nii.gz}_nFAChange.nii.gz

    if [ $long_flag -eq 0 ];
    then
	echo "fslmaths  ${ARRAY[ $counter -1 ]}  ${ARRAY[ $counter ]} (T3-T1/T1)"
	
	fslmaths   ${ARRAY[ $counter ]} -sub ${ARRAY[ $counter -1 ]} temp
	fslmaths temp -div   ${ARRAY[ $counter -1 ]}  $FACHANGE
	rm temp.nii.gz

	long_flag=1
    else
	long_flag=0
    fi
done




################################################
#USEFULE SCRIPTS....
#FOR LOOPS

#for FILE in $( ls  $SOURCE*$2*); 
# do
#    echo $FILE
#done


#IF STATEMENTS
#if [ something == ?? ] ; then
#elif 
#else
#fi

#DECLARING ARRAYS
# declare -a ARRAY=( s f g fdw da fd s )
#To access the array:
#Something=${ARRAY[ $counter ]}

#TO CHECK ARRAY LENGTH
#length=${#ARRA[@]}

#COUNTER AND COUNTER++
#counter=1
#counter=((counter++))



#To bring $1 as array:
#for FILES in "$@" ; do
#<SOMETHING>
#done


#REMOVE ALPHANUMERICAL VALUES
#and "."
#FILE=$( ls $FILES | tr -d [:alpha:] )
#SBNAME=${FILE//.}



#AWK to check all markes exist....
#$ awk '{
#if ($3 =="" || $4 == "" || $5 == "")
#	print "Some score for the student",$1,"is missing";'}' student-marks

##################################################
