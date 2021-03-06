#!/bin/bash
#Rodrigo Perea
#Goal: First Step to run tract_ROI. It will check for the directory with the ROIs are located (from prob. atlas JHU) and
#start the process.
#TO RUN




SOURCE=$( pwd )

#if [ $1 -z ] ; then
 #  echo "Error.
#Input the labels you want to use. (e.g. drigo_tract_ROI_JHU_ all_smFA.nii.gz )"
#    exit
#fi

echo "Enter number of images in the 4d volume (e.g. 41)"
read -e VOLUMES

echo "Enter the 4d volume name (Hit enter for all_sFA_.nii.gz)"
read -e VOL4D

if [ $VOL4D -z ]; then
    VOL4D=all_sFA.nii.gz
fi





#Variables to initialize
IMAGE=$1
declare -a TRACNAME=( ATR-L ATR-R CingCG-L CingCG-R CingH-L CingH-R CST-L CST-R FMa FMi ILF-L ILF-R IFOF-L IFOF-R SLFTemp-L SLFTemp-R SLF-L SLF-R UF-L UF-R )
declare -a MASKS=( masks_thr50_1mm_Anterior_Thalamic-Radiatino-L.nii.gz masks_thr50_1mm_Anterior_Thalamic-Radiatino-R.nii.gz masks_thr50_1mm_Cingulum-L.nii.gz masks_thr50_1mm_Cingulum-R.nii.gz masks_thr50_1mm_Cingulum_Hippo-L.nii.gz masks_thr50_1mm_Cingulum_Hippo-R.nii.gz masks_thr50_1mm_Corticospinal_Tract-L.nii.gz masks_thr50_1mm_Corticospinal_Tract-R.nii.gz masks_thr50_1mm_Forceps_Major.nii.gz masks_thr50_1mm_Forceps_Minor.nii.gz masks_thr50_1mm_Inf-Long_Fasc-L.nii.gz masks_thr50_1mm_Inf-Long_Fasc-R.nii.gz masks_thr50_1mm_Inf_Fronto_Occipital-L.nii.gz masks_thr50_1mm_Inf_Fronto_Occipital-R.nii.gz masks_thr50_1mm_Sup-Long_Fas_TemporalPart-L.nii.gz masks_thr50_1mm_Sup-Long_Fas_TemporalPart-R.nii.gz masks_thr50_1mm_Superior-Long_Fasc-L.nii.gz masks_thr50_1mm_Superior-Long_Fasc-R.nii.gz masks_thr50_1mm_Uncinate_Fasc-L.nii.gz masks_thr50_1mm_Uncinate_Fasc-R.nii.gz )


MASKDIR="/BRAIN/ATLAS_DTI/masks_thr50_1mm"
PREFIX="masks_thr50"
POST="50thr"


for looop in {1..41} 
do    

    echo "In ${MASKS[ $counter ] } ..."
    TRACMASK=${MASKS[ $counter ]}
    TRAC=${TRACNAME[ $counter ]}
    
    MASKIN=$MASKDIR/$TRACMASK
    TRACOUT=$SOURCE/$TRAC
    TRACO=${TRACNAME}_$POST

    echo ""
    fslmaths $VOL4D -mul $MASKIN $TRACO
    fslstats -t $TRACO -M >> means_${TRACO}.txt
    cat means_${TRACO}.txt
    counter=$(($counter+1))
    
#"
done


