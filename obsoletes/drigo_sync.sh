#!/bin/bash

PWD=$( pwd )

echo "Copying drigos...to toKUADC...."
cp ~/DrigoScripts/drigo_XNAT_TO_nii.sh ~/DrigoScripts/to_KUADC/KUADC_XNAT_TO_NII.sh
cp ~/DrigoScripts/drigo_KUADC_naming.sh ~/DrigoScripts/to_KUADC/KUADC_naming.sh
cp ~/DrigoScripts/drigo_FS_QSUBSRas.sh ~/DrigoScripts/to_KUADC/KUADC_FS_QSUBS.sh
cp ~/DrigoScripts/drigo_QSUBBER.sh ~/DrigoScripts/to_KUADC/KUADC_QSUBBER.sh
cp ~/DrigoScripts/drigo_renamer ~/DrigoScripts/to_KUADC/drigo_renamer
cp ~/DrigoScripts/drigo_FS2_QSUBS.sh ~/DrigoScripts/to_KUADC/KUADC_FS2_QSUBS.sh

echo "Copying home Drigoscripts to kus-imaging, kus-imaging2, hpc.quant.ku.edu....:"

echo "rperea@kus-imaging2 pass...? "
scp -r /Users/rperea/DrigoScripts/* rperea@kus-imaging2:~/.DrigoScripts/
ssh rperea@kus-imaging2 chmod -R 755 /home/rperea/.DrigoScripts/*
echo "rperea@kus-imaging pass?"
scp -r /Users/rperea/DrigoScripts rperea@kus-imaging:/
ssh rperea@kus-imaging chmod -R 755 /DrigoScripts/*

echo "rperea@hpc.quant.ku.edu?"
scp -r /Users/rperea/DrigoScripts/* rperea@hpc.quant.ku.edu:~/.DrigoScripts/
ssh rperea@hpc.quant.ku.edu chmod -R 755 /home/rperea/.DrigoScripts
