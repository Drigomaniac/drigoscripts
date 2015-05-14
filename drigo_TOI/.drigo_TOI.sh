#!/bin/bash
#Rodrigo Perea
#Goal: This script takes * (e.g. RD) normalized maps in an all_*.nii.gz (all_RD.nii.gz) generally coming from tbss_4 4D volume and gives mean values for the specific atlas regions from JHU. 
#TO RUN
#  $drigo_JHUmeans.sh all_smRD.nii.gz <either '25' or 'labels' depending on the trac you want to use>



SOURCE=$( pwd )
#Variables to initialize
IMAGE=$1
declare -a TRACACRO=( ATR-L ATR-R BodyCC CingCG-L CingCG-R CingH-L CingH-R CST-L CST-R FMa FMi GenuCC IFOF-L IFOF-R  ILF-L ILF-R SLF-L SLF-R SpleniumCC UF-L UF-R )
    

TRACTDIR="/BRAIN/ATLAS_DTI/masks_thr25_1mm"
    TRACTPREFIX="mask_thr25_1mm_"
    
    
    for TRACT in $( ls $TRACTDIR/$TRACTPREFIX* ) 
    do    
	TRACRO=tract_25_1mm_${TRACACRO[ $counter ]}
	TCNAME=$( basename $TRACT )
	TCNAME=${TCNAME/.nii.gz}
	TCNAME=${TCNAME/mask_thr25_1mm_/means_thr25_1mm_}
#	TCNAME=thr25_1mm_${TCNAME}
	counter=$(($counter+1))

#echo "
	if [ -a means_${TRACRO}.txt ] ; 
	then
	    echo "Skipped tract. Remove to proceed: means_${TRACRO}.txt"
	else
	    echo "For file in $1 in tract $TCNAME..."
	    fslmaths $IMAGE -mul $TRACT $TRACRO
		fslstats -t $TRACRO -M >> means_${TRACRO}.txt
		cat means_${TRACRO}.txt
		
	fi
#"
    done

