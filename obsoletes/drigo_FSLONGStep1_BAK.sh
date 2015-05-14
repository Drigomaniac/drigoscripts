#!/bin/bash

SOURCE=$(pwd)

for DIR in WU_10077_T0 WU_22160_T0 WU_60614_T0 WU_61509_T0 WU_61637_T0 WU_61885_T0 WU_61978_T0 WU_62229_T0 WU_62497_T0 WU_62547_T0 WU_64291_T0 WU_64387_T0 WU_72152_T0 WU_84885_T0 WU_84888_T0
do
DIRA=${DIR//_T0}
DIRTMP=${DIR//TEMP}
echo "In directory...$DIRA "
 echo "
#PBS -N $DIR
#PBS -l nodes=1:ppn=2
#PBS -q default      
#PBS -M rperea@ittc.ku.edu
#PBS -m abe
#PBS -j oe                                                  

export SUBJECTS_DIR=$SOURCE
$FREESURFER_HOME/bin/recon-all -base ${DIRA}_TMP -tp ${DIR}_MPRAGE -tp ${DIRA}_T1_MPRAGE -all | tee $SOURCE/tee_${DIR}_FSTMP " >> ./QSUB_$DIR.qsub

done


