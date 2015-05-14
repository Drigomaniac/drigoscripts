#!/bin/bash

#MAke sure you are in the orig directory from TBSS-1_2_3
#if [ $1 -eq '--help' ]  then
#
#echo "1 will be the DTIFIT you want.... $2 will be the directory name ../MD or ../RD or ../AxD 
#
#"
#fi


for FILE in $( ls *.gz )  ; 
do 
	FILE=${FILE/coreg_}
    echo  "File is: $FILE "

  #cp ../../../RAW_IMAGES/ADEPT/OnlyOneTimepoint/OnlyT1/${FILE/_FA.nii.gz}_${1}.nii.gz  ../../../../RAW_IMAGES/ADEPT/OnlyOneTimepoint/Waiting_For_T3/${FILE/_FA.nii.gz}_${1}.nii.gz ../../../../RAW_IMAGES/ADEPT/TwoTimepoints/${FILE/_FA.nii.gz}_${1}.nii.gz   $2  
#cp ../../../RAW_IMAGES/TEAM/Two*/${FILE/_FA.nii.gz}_${1}.nii.gz $2
cp ../../../../../RAW_IMAGES/ADEPT/Two*/${FILE/_FA.nii.gz}_${1}.nii.gz $2
done


