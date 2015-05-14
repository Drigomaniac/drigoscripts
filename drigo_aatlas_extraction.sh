#!/bin/bash
#Rodrigo Perea
#Goal: This script takes * (e.g. RD) normalized maps in an all_*.nii.gz (all_RD.nii.gz) generally coming from tbss_4 4D volume and change the names to a parent */ (e.g. ../RD/) directory.


counter=1
FILE=$1


#declare -a NAME=( MiddleCerebellarPeduncle_ Pontine_crossing_tract_a_part_of_MCP_ Genu_of_corpus_callosum_ Body_of_corpus_callosum_ Splenium_of_corpus_callosum_ Fornix_column_and_body_of_fornix_ Corticospinal_tract_R_ Corticospinal_tract_L_ Medial_lemniscus_R_ Medial_lemniscus_L_ Inferior_cerebellar_peduncle_R_ Inferior_cerebellar_peduncle_L_ Superior_cerebellar_peduncle_R_ Superior_cerebellar_peduncle_L_ Cerebral_peduncle_R_ Cerebral_peduncle_L_ Anterior_limb_of_internal_capsule_R_ Anterior_limb_of_internal_capsule_L_ Posterior_limb_of_internal_capsule_R_ Posterior_limb_of_internal_capsule_L_ Retrolenticular_part_of_internal_capsule_R_ Retrolenticular_part_of_internal_capsule_L_ Anterior_corona_radiata_R_ Anterior_corona_radiata_L_ Superior_corona_radiata_R_ Superior_corona_radiata_L_ Posterior_corona_radiata_R_ Posterior_corona_radiata_L_ Posterior_thalamic_radiation_include_optic_radiation_R_ Posterior_thalamic_radiation_include_optic_radiation_L_ Sagittal_stratum_include_inferior_longitidinal_fasciculus_and_inferior_fronto-occipital_fasciculus_R_ Sagittal_stratum_include_inferior_longitidinal_fasciculus_and_inferior_fronto-occipital_fasciculus_L_ External_capsule_R_ External_capsule_L_ Cingulum_cingulate_gyrus_R_ Cingulum_cingulate_gyrus_L_ Cingulum_hippocampus_R_ Cingulum_hippocampus_L_ Fornix_cres_Stria_R_ Fornix_cres_Stria_terminalis_L_ Superior_longitudinal_fasciculus_R_ Superior_longitudinal_fasciculus_L_ Superior_fronto-occipital_fasciculus_could_be_a_part_of_anterior_internal_capsule_R_ Superior_fronto-occipital_fasciculus_could_be_a_part_of_anterior_internal_capsule_L_ Uncinate_fasciculus_R_ Uncinate_fasciculus_L_ Tapetum_R_ Tapetum_L_ )

declare -a NAME=( Caudate	Cerebellum	Frontal_Lobe	Insula	Occipital_Lobe	Parietal_Lobe	Putamen	Temporal_Lobe	Thalamus )



while [ $counter -le 9 ] 
do
    TRACT=mask_MNI_${NAME[ $(($counter -1 ))]}_1mm_25thr
    index=$(($counter  ))
    echo "
$FILE index $index will be changed with $TRACT"
    
    echo "fslmaths $1 -thr $index -uthr $index $TRACT
fslmaths $TRACT -div $(($index)) $TRACT
    "
    fslmaths $1 -thr $index -uthr $index $TRACT
    fslmaths $TRACT -div $(($index)) $TRACT
    counter=$(($counter + 1 ))
done

