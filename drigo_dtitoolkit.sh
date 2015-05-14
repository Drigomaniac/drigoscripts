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
    echo "Goal: To generate the TackVis necessary files usign Diffusion Toolkit 0.6.2.2.
	This script have been personally implemented for the Skyra MRI scanner (using 64+1 gradient directions
Please include the HSC# as the 1st argument.

The script will read each folde and assumes that the *dcm files are under $DIREC/* 


 "

    exit
fi
if  [ -z $1 ] ; then
    echo "Goal: To generate the TackVis necessary files usign Diffusion Toolkit 0.6.2.2.
        This script have been personally implemented for the Skyra MRI scanner (using 64+1 gradient directions
Please include the HSC# as the 1st argument.

Or --help for help  "
    exit
fi

for DIR $(ls -1d $1 )  ; then
DCMFILE=$( ls $DIR/*dcm | head -n 1 ) 
echo $DCMFILE
done


