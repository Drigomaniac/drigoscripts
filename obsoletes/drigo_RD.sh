#!/bin/bash
#Rodrigo Perea
#Goal: Create radial diffusivity maps from existing eigenvalues L1, L2, and L3.
#MAKE SURE you are in the present working directory and that L1, L2, and L3 are there as they will be used for dependencies.

#Dependencies:
#1. FSL and DTIFIT outputs L1, L2, L3
#2. fslmaths, part of FSL

for FILE in *L2*

do

echo "File is $FILE"
L2=$FILE
L3=${FILE/L2/L3}
RD=${FILE/L2/RD}
echo "Computing RD in $RD....."
fslmaths $L2 -add $L3 -div 2 $RD

done

