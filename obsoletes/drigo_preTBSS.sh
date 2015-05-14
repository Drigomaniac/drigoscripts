#!/bin/bash

SOURCE=$( pwd )
cd $SOURCE

echo "BET? (y/n)"
read BET

echo "DTIFIT?(y/n)"
read DTIFIT

if [ $DTIFIT = 'y' ] ; then
echo "What bvals/bvecs should I use (old/new)? "
read BVs
fi	


for FILE in *DTIec.nii.gz
do
if [ $BET = 'y' ] ;
then    
echo "Doing  bet  $FILE ${FILE/.nii.gz}_bet -m" 
bet $FILE ${FILE/.nii.gz}_bet -m -f 0.3
fi

if [ $DTIFIT = 'y' ] ; then
    	
#eddy_correct $FILE ${FILE}_ec 0 
    if [ $BVs =  'old' ] ; then
	BVEC=bvecs
	BVAL=bvals
    elif [ $BVs =  'new' ] ; then
	BVEC=bvecsNew
	BVAL=bvalsNew
    else
	echo "Error, old for 42 direction bvecs/bvlas  new for 65 direction bvecs/bvals."
	exit
    fi
        echo "Doing dtifit -k $FILE -o ${FILE/.nii.gz} -m  ${FILE/.nii.gz}_bet_mask -r $BVEC  -b $BVAL 	"
    dtifit -k $FILE -o ${FILE/.nii.gz} -m ${FILE/.nii.gz}_bet_mask -r $BVEC -b $BVAL
fi
    
done
