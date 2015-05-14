#!/bin/bash
DIR=$( pwd )

# Load text file lines into a bash array.
count=1
#Setting IDs into th eID array...
OLD_IFS="$IFS"
IFS=$'
'
#ID=( $(cat "./ID.txt") )
#ID=($(<../../../../../Spreadsheets/ID.txt))
ID=($(<./ID2.txt))

IFS=$OLD_IFS



#Setting MAP IDs into th eID array...
OLD_IFS=$IFS
IFS=$' \n'
MAP=( $(cat "./MAP.txt") )
IFS=$OLD_IFS


#Setting Timepoints into th eID array...
OLD_IFS=$IFS
IFS=$' \n'
Timepoint=( $(cat "./Timepoint.txt") )
IFS=$OLD_IFS

#How to add counter strings...
COUNTER=0


echo "ID 0 is: ${ID[0]} and ID 1 is: ${ID[1]} and ID 100 is: ${ID[100]} "
echo "MAP 0 is: ${MAP[0]} and MAP 1 is: ${MAP[1]} and MAP 100 is: ${MAP[100]} "

while [ $COUNTER -lt 323 ]; do
    echo "Copying ${ID[$COUNTER]} to USABLE..."
    mv ${ID[$COUNTER]}-MPRAGE.nii WU_${MAP[$COUNTER]}_${Timepoint[$COUNTER]}_MP#RAGE.nii 

 let COUNTER=COUNTER+1
done
