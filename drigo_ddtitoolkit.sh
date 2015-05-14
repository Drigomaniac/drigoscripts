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

for DIR in $( ls -1d $1*) ; 

do
DCMFILE=$( ls $DIR/*dcm | head -n 1 ) 
GRADIENT=/BRAIN/gradient65.txt
echo $DCMFILE
mkdir -p $SOURCE/temp
TEMP=$SOURCE/temp/
TEMPFILE=$SOURCE/temp/tmp
echo "


In $DIR ...

 "
diff_unpack $DCMFILE $TEMPFILE -ot nii
dti_recon $TEMPFILE ${DIR}/dti -gm $GRADIENT -b 1000 -b0 1 -oc -p 3 -sn 1 -ot nii
dti_tracker ${DIR}/dti $TEMP/track_tmp.trk -at 35 -m $DIR/dti_dwi.nii -it nii
spline_filter $TEMP/track_tmp.trk 1 $DIR/dti.trk
rm -r $TEMP

mkdir -p trackvis_${DIR}
mv $DIR/dti* trackvis_${DIR}/

done


