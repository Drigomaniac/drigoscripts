#!/bin/bash
#Rodrigo Perea
#Goal: This script takes * (e.g. RD) normalized maps in an all_*.nii.gz (all_RD.nii.gz) generally coming from tbss_4 4D volume and change the names to a parent */ (e.g. ../RD/) directory.


counter=0

declare -a array=( 11883_002_01_DTIec_FA.nii.gz 11883_031_02_DTIec_FA.nii.gz 11883_032_01_DTIec_FA.nii.gz 11883_038_01_DTIec_FA.nii.gz 11883_065_02_DTIec_FA.nii.gz 11883_071_02_DTIec_FA.nii.gz 11883_073_02_DTIec_FA.nii.gz 11883_087_01_DTIec_FA.nii.gz 11883_089_01_DTIec_FA.nii.gz 11883_090_01_DTIec_FA.nii.gz 11883_092_01_DTIec_FA.nii.gz 11883_093_01_DTIec_FA.nii.gz 11883_094_01_DTIec_FA.nii.gz 11883_099_01_DTIec_FA.nii.gz 11883_101_01_DTIec_FA.nii.gz 11883_104_01_DTIec_FA.nii.gz 11883_110_01_DTIec_FA.nii.gz 11883_116_01_DTIec_FA.nii.gz 11883_118_01_DTIec_FA.nii.gz 11883_121_01_DTIec_FA.nii.gz 11883_122_01_DTIec_FA.nii.gz 11883_125_01_DTIec_FA.nii.gz 11883_127_01_DTIec_FA.nii.gz 11969_001_01_DTIec_FA.nii.gz 11969_003_01_DTIec_FA.nii.gz 11969_005_01_DTIec_FA.nii.gz 11969_007_01_DTIec_FA.nii.gz 11969_008_01_DTIec_FA.nii.gz 11969_009_01_DTIec_FA.nii.gz 11969_011_01_DTIec_FA.nii.gz 11969_012_01_DTIec_FA.nii.gz 11969_014_01_DTIec_FA.nii.gz 11969_016_01_DTIec_FA.nii.gz 11969_017_01_DTIec_FA.nii.gz 11969_018_01_DTIec_FA.nii.gz 11969_019_01_DTIec_FA.nii.gz 11969_021_01_DTIec_FA.nii.gz 11969_022_01_DTIec_FA.nii.gz 11969_023_01_DTIec_FA.nii.gz 11969_024_01_DTIec_FA.nii.gz 11969_025_01_DTIec_FA.nii.gz 11969_027_01_DTIec_FA.nii.gz 11969_028_01_DTIec_FA.nii.gz 11969_030_01_DTIec_FA.nii.gz 11969_031_01_DTIec_FA.nii.gz 11969_033_01_DTIec_FA.nii.gz 11969_034_01_DTIec_FA.nii.gz 11969_036_01_DTIec_FA.nii.gz 11969_037_01_DTIec_FA.nii.gz 11969_039_01_DTIec_FA.nii.gz 11969_042_01_DTIec_FA.nii.gz 11969_043_01_DTIec_FA.nii.gz 11969_046_01_DTIec_FA.nii.gz 11969_047_01_DTIec_FA.nii.gz 11969_048_01_DTIec_FA.nii.gz 11969_050_01_DTIec_FA.nii.gz 11969_052_01_DTIec_FA.nii.gz 11969_053_01_DTIec_FA.nii.gz  )


for FILE in $( ls vol* ) 
do
echo " $FILE will be changed with  ${array[ $counter ]} "
mv $FILE ${array[ $counter ] }


counter=$(($counter + 1 ))
done

