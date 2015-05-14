#!/bin/bash

SOURCE=$(pwd)
mkdir -p $SOURCE/QSUBS

for DIR in $( ls -d WU*T0* )
do
DIRA=${DIR//_T0*}

DIRTMP=${DIR//TEMP}
echo "In directory...$DIRA "
 echo "
#PBS -N FSLSt12_${DIR}
#PBS -l nodes=1:ppn=2
#PBS -q default      
#PBS -M rperea@ittc.ku.edu
#PBS -m abe
#PBS -j oe                                                  

export SUBJECTS_DIR=$SOURCE
$FREESURFER_HOME/bin/recon-all -base ${DIRA}_TMP -tp ${DIR} -tp ${DIRA}_T1_MPRAGE -tp ${DIRA}_T2_MPRAGE -all | tee $SOURCE/tee_${DIRA}_FSTMP " >> $SOURCE/QSUBS/${DIR}_FS2TMP.qsub

done


