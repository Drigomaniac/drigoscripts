#!/bin/bash
SOURCE=$(pwd)
QSUB="L_QSUB"
mkdir -p $SOURCE/$QSUB

for DIR in $(ls -1d $SOURCE/$1* ) ;
do
echo "In $DIR"


cd $DIR
rm targets-L*
#Generating targets-L.txt and targets-R.txt
for targetsL in $( ls Targets/L* ) ;
do
  echo "$DIR/$targetsL " >> targets-L.txt
done
cd ..





echo "#PBS -N L_$(basename ${DIR/bedpostX})
#PBS -l nodes=2:ppn=1,mem=4000m
#PBS -q default      


$FSL_DIR/bin/probtrackx2 -x $DIR/Thalamus-L.nii.gz -l --loopcheck --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --xfm=$DIR/xfms/str2diff.mat --meshspace=freesurfer --seedref=$DIR/FS_brain.nii.gz --avoid=$DIR/FS_R_brain.nii.gz  --forcedir --opd -s $DIR/merged -m $DIR/nodif_brain_mask --dir=$DIR/7L-Thalamus-Tract --targetmasks=$DIR/targets-L.txt --os2t --otargetpaths" >> $SOURCE/$QSUB/$(basename ${DIR}).qsub  
done
