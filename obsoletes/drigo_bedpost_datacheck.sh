#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#Goal: This script runs bedpostx_datacheck in more than on directory
#Any questions please feel free to contact me at the email provided above.


SOURCE=$( pwd )

#Checking what you are doing.....
if  [ $1 = "--help" ] ; then
    echo "to run:
drigo_bedpost_datacheck <HSC number>"
    exit
fi

################################################
#USEFULE SCRIPTS....
#FOR LOOPS

for DIR in $( ls  -d $SOURCE/$1*/); 
 do
  
bedpostx_datacheck $DIR

done


#IF STATEMENTS
#if [ something == ?? ] ; then
#elif 
#else
#fi

#DECLARING ARRAYS
# declare -a ARRAY=( s f g fdw da fd s )


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
