#!/bin/bash

SOURCE=$(pwd)

for DIR in $( ls -d *T0_MPRAGE )  
do
TP1=${DIR}
#TP2=${DIR//_T0}_T1_MPRAGE
TMP=${DIR//_T0_MPRAGE}_TMP
echo "In directory...$DIR "
 echo "
#PBS -N ${TP1}_step2
#PBS -l nodes=3:ppn=2
#PBS -q default      
#PBS -M rperea@ittc.ku.edu
#PBS -m abe
#PBS -j oe                                                  

export SUBJECTS_DIR=$SOURCE
$FREESURFER_HOME/bin/recon-all -long $TP1 $TMP -all | tee $SOURCE/tee_${TP1}_FSLStep2 " >> $SOURCE/${DIR}_FSLStep2.qsub

done


for DIR in $( ls -d *T1_MPRAGE ) 
do
TP2=${DIR}
TMP=${DIR//_T1_MPRAGE}_TMP
echo "In directory...$DIR "
 echo "
#PBS -N ${TP2}_step2
#PBS -l nodes=3:ppn=2
#PBS -q default      
#PBS -M rperea@ittc.ku.edu
#PBS -m abe
#PBS -j oe                                                  

export SUBJECTS_DIR=$SOURCE
$FREESURFER_HOME/bin/recon-all -long $TP2  $TMP  -all | tee $SOURCE/tee_${TP2}_FSLStep2 " >> $SOURCE/${TP2}_FSLStep2.qsub

done


for DIR in $( ls -d *T2_MPRAGE ) 
do
TP3=${DIR}
TMP=${DIR//_T2_MPRAGE}_TMP
echo "In directory...$DIR "
 echo "
#PBS -N ${TP3}_step2
#PBS -l nodes=3:ppn=2
#PBS -q default      
#PBS -M rperea@ittc.ku.edu
#PBS -m abe
#PBS -j oe                                                  

export SUBJECTS_DIR=$SOURCE
$FREESURFER_HOME/bin/recon-all -long $TP3  $TMP  -all | tee $SOURCE/tee_${TP2}_FSLStep2 "  >> $SOURCE/${TP3}_FSLStep2.qsub

done


