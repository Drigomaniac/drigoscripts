#!/bin/bash
#Rodrigo Perea
#Goal: Type --help or check the help if statement 
#TO RUN
#  $drigo_JHUmeans.sh all_smRD.nii.gz <either '25' or 'labels' depending on the trac you want to use>



SOURCE=$( pwd )
#Variables to initialize



if [ $1 = "--help" ] ; 
then
    echo "
Enter all_s<FA/RD>.nii.gz as the first argument and run it from the <FA/RD>_TOI/ folder!"
    echo "This script will:
     1. Locate the TOI_mask regions from ir default directory (/BRAIN/ATLAS_DTI/masks_thr25_1m )
     2. Multiple all the  masks with all_sFA.nii.gz
     3. fslstats the Mean values on each mask. 
    
"
    exit
fi




#Variable declarations:

declare -a TRACACRO=( ATR-L ATR-R BodyCC CingCG-L CingCG-R CingH-L CingH-R CST-L CST-R FMa FMi GenuCC IFOF-L IFOF-R  ILF-L ILF-R SLF-L SLF-R SpleniumCC UF-L UF-R )
    

TRACTDIR="/BRAIN/ATLAS_DTI/masks_thr25_1mm"
TRACTPREFIX="mask_thr25_1mm_"
IMAGE=$1    
    


#------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------

if [ ! -z $@  ] ; then

    
    for TRACT in $( ls $TRACTDIR/$TRACTPREFIX* ) 
    do    
	echo "TRACT will be related to ${TRACACRO[ $counter ]} ..."
	TRACRO=tract_25_1mm_${TRACACRO[ $counter ]}
	TRACRO_THR=thr0.2_tract_25_1mm_${TRACACRO[ $counter ]}
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
	   
	    echo "For file in $IMAGE in tract $TCNAME... (Thresholded at FA >0.2"

	    #If in FA, then we will threshold the values to 0.2
#	    if [ $1="all_sFA.nii.gz" ] ; 
#	    then
		fslmaths $IMAGE -mul $TRACT $TRACRO
		fslmaths $TRACRO -thr 0.2 $TRACRO_THR
		fslstats -t $TRACRO_THR -M >> thr0.2_means_${TRACRO}.txt
		cat thr0.2_means_${TRACRO}.txt
	#Else, we will convert the already thresholded FA into a mask and use it for stats (For RD, AxD) 
#	    else
#		fslmaths ../FA_TOI/$TRACRO_THR -div ../FA_TOI/$TRACRO_THR $TRACRO_THR
#		fslstats -t $TRACRO_THR -M >> thr0.2_mean_${TRACRO}.txt
#		cat thr0.2_means_${TRACRO}.txt
#	    fi
	fi
    done
else
    echo "ERROR//!!"
    echo "Enter FA/RD as the first argument and run it from ../stats present directory!"
    echo "This script will:
     1. Create a $\1_FA (e.g. FA_TOI) folder
     2. Copy the all_FA.nii.gz into FA_folder
    
"
    exit
fi


