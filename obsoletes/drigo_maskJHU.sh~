#!/bin/bash
#Rodrigo Perea
#Goal: This script takes * (e.g. RD) normalized maps in an all_*.nii.gz (all_RD.nii.gz) generally coming from tbss_4 4D volume and gives mean values for the specific atlas regions from JHU. 
#TO RUN
#  $drigo_JHUmeans.sh all_smRD.nii.gz <either '25' or 'labels' depending on the trac you want to use>



SOURCE=$( pwd )

#if [ $1 -z ] ; then
#    echo "Error.
#Input the image you want to retrieve the mean values as the first argument. (e.g. drigo_JHUmeans all_smFA.nii.gz )"
#    exit
#fi


#Variables to initialize
IMAGE=$1
#TEMP=$3


#echo "Where are the tracts located (if in /BRAIN/ATLAS_DTI/masks_thr25_1mm  hit enter) ?"
#read -e TRACTDIR
#TRACTDIR="/BRAIN/ATLAS_DTI/mask_JHU_ICBM_labels_1mm"


#if [ $TRACTDIR -z ]; then
#    TRACTDIR="/BRAIN/ATLAS_DTI/masks_thr25_1mm"
#fi



#echo "What is the prefix of the tracts (if mask_thr25_1mm_ , hit enter)? "
#read -e TRACTPREFIX
#TRACTPREFIX="mask_JHU_ICBM_labels"

#if [ $TRACTPREFIX -z ] ; then
#    TRACTPREFIX="mask_thr25_1mm_"
#fi


if [ $2 = "labels" ] ; then
    
    declare -a TRACACRO=( ACR-L ACR-R AntLimbIntCap-L AntLimbIntCap-R Body-CC CerPedunc-L CerPedunc-R CinguCG-L CinguCG-R CinguH-L CinguH-R CST-L CST-R ExtCaps-L ExtCaps-R ForColBody FornixCresStria-R FornixCresStriTerm-L Genu InfCerPedunc-L InfCerPedunc-R  MedLemnis-L MedLimnis-R MidCerePed PontCross PostCR-L PostCR-R PostLimbIntCap-L PostLimbIntCap-R PostTRwOpticRad-L PostTRwOpticRad-R RetroInterCap-L RetroInterCap-R STRAT_ILF_IFOF-L STRAT_ILF_IFOF-R Splenium SupCerPedunc-L SupCerPedunc-R SupCR-L SupCR-R SupFOF-L SupFOF-R SLF-L SLF-R Tapetum-L Tapetum-R UF-L UF-R ) 
    TRACTDIR="/BRAIN/ATLAS_DTI/mask_JHU_ICBM_labels_1mm"
    TRACTPREFIX="mask_JHU_ICBM_labels"

    for TRACT in $( ls $TRACTDIR$TRACT/$PREFIX* ) 
    do
	TRACRO=tract_JHU_labels_${TRACACRO[ $counter ]}

	TCNAME=$( basename $TRACT )
	TCNAME=${TCNAME/.nii.gz}
	TCNAME=${TCNAME/mask_JHU_ICBM_labels_/means_JHU_labels_}
	counter=$(($counter+1))
	echo " In track $TCNAME ..."
#	echo "
    fslmaths $IMAGE -mul $TRACT $TRACRO
    fslstats -t $TRACRO -M >> means_${TRACRO}.txt
    cat means_${TRACRO}.txt

    
#"

    done
    
    
elif [ $2 = "25" ] ; then
    
    declare -a TRACACRO=( ATR-L ATR-R CingCG-L CingCG-R CingH-L CingH-R CST-L CST-R FMa FMi ILF-L ILF-R IFOF-L IFOF-R SLFTemp-L SLFTemp-R SLF-L SLF-R UF-L UF-R )
    
    TRACTDIR="/BRAIN/ATLAS_DTI/masks_thr25_1mm"
    TRACTPREFIX="mask_thr25_1mm_"
    
    
    for TRACT in $( ls $TRACTDIR$TRACT/$PREFIX* ) 
    do    
	TRACRO=tract_25_1mm_${TRACACRO[ $counter ]}
	TCNAME=$( basename $TRACT )
	TCNAME=${TCNAME/.nii.gz}
	TCNAME=${TCNAME/mask_thr25_1mm_/means_thr25_1mm_}
#	TCNAME=thr25_1mm_${TCNAME}
	counter=$(($counter+1))
	echo " In track $TCNAME ..."
#echo "
    fslmaths $IMAGE -mul $TRACT $TRACRO
    fslstats -t $TRACRO -M >> means_${TRACRO}.txt
    cat means_${TRACRO}.txt

    
#"
    done
fi

