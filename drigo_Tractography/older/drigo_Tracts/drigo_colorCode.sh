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

function help {
  echo "Instructions to be entered here....
\$1 should be the start of the mask (most likelye L- or R- )...
"
    exit

}


#Checking what you are doing.....
if  [ $1 = "--help" ] ; 
then
    help
fi



if [ -z  $* ]; 
then
    help
fi

for DIR in $(ls -1d 119* ) ;
do
    
    echo "In $DIR ... "
    counter=1
    for FILE in  $(ls -d $DIR/7RegionThalamus/$1*.gz ) ;
    do
	echo "In file $FILE..., index is $counter"
#    fslmaths $FILE -div $FILE temp
   # fslmaths temp -mul $counter c_$FILE
	
	if [ $counter != "1" ] ;
	then
#	echo "Counter is $counter "
	   fslmaths $FILE -mul  $counter $DIR/temp
	    fslmaths  $DIR/${1}Color7 -add $DIR/temp $DIR/${1}Color7
	else
	    
	    cp $FILE $DIR/${1}Color7.nii.gz
	fi
	rm $DIR/temp.nii.gz
	counter=$(($counter+1))
#    rm temp.nii.gz
    done
  
done