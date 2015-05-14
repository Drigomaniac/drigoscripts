#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#PLEASE ADD DESCRIPTION HERE:!!!!!!
#
#
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.
#Registration methods for Longitudinal analyses....

SOURCE=$( pwd )

#Checking what you are doing.....
if  [ $1 = "--help" ] ; then
    echo "\$1 is the ref timepoint (e.g. 01) of the files in the tbss processing pipeline orighdata folder.
\$2 is the diffusivity marker (RD, FA, etc...)
\$3 is the timepoint you will modify (e.g. 03) "
    exit
fi

################################################
#USEFULE SCRIPTS....
#FOR LOOPS

for FILE in $( ls  *_$3_$2.nii.gz ); 
 do

    OMAT=$3_to_$3r_using_${FILE/$3/$1}
    OMAT=${OMAT/.nii.gz}.mat
    echo "In file $FILE ..."
    #echo "flirt -in ${FILE} -ref ${FILE/$3/$1} -out ${FILE/$3/$3r} -omat $3_to_$3r_using_${FILE/$3/$1}.mat  "
    flirt -in ${FILE} -ref ${FILE/_$3_/_$1_} -out ${FILE/_$3_/_$3r_} -omat $OMAT  
    echo "....done"

done

