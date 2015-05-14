#!/bin/sh

#   tbss_non_FA - project non-FA data onto the skeleton


#   tbss_non_FA - project non-FA data onto the skeleton
if [ $4 -z ] ;then

    echo "Usage: tbss_non_FA <prefix_* >"
    echo "Dependencies: warp fields (in a subdirectory warp_fields) to MNIed template and the non_FA images in the folder"
    echo "Make sure your first argument is your prefixed images \$1"
    echo "And the second argument (\$2) is your FA generated template"
    echo "and the 3rd argument is the type of DTI!! (E.g. RD, MD, etc...)"
    echo "Finally \$4 is the generated template in MNI space
"
exit
fi

#Step0: EXECUTING MIDPOINT TRANSFORMATION (only for longitudinal data)

echo "Is your data longitudinal (y/n) ? "
read $LONGI
if [ $LONGI = y ] ; then
#Not tested as I executed this step before creating this script...
    mkdir -p Step0_Midtrans 
    cp *gz Step0_Midtrans
    cd Step0_Midtrans
    drigo_coreg_half_long.sh
    cp coreg* ../
    cd ..
elif [ $LONG = 'n' ] ; then
    echo "Cross-sectional data, no need to midtranforme. Skipping Step0..."
else
    echo "Incorrect answer, please re-run..."
    exit
fi


#Step1: REGISTERING TO MNI
best=$2
mkdir -p Step1_NonFA_to_Template
#--->>> NEED TO FIX HERE---> cp generated output from Step0 to the directory  Step1_NonFA_to_Template

# cp <THESE_FILES> into  Step1_NonFA_to_Template/

cd  Step1_NonFA_to_Template
echo "template is $2"
for f in $1* ; do
    g=${f//$3*}
    warp=$(ls warp_fields/*$g*)
    echo "Applying warp field $warp into $f ... "
    
    $FSLDIR/bin/applywarp -i $f -o ${f//.nii.gz}_to_template -r $2 -w $warp

done


#Step2: REGISTERING THE NON-FAs to  MNI
mkdir -p Step2_Register_To_MNI
#--->>> NEED TO FIX HERE---> cp generated output from Step1 to the directory  Step2_Register_To_MNI
# cp <THESE_FILES> into  Step2_Register_To_MNI
#cd  Step2_Register_To_MNI
for FILE2 in $( ls *${f//.nii.gz}_to_template* ) ; 
do
    echo $FILE2
    antsRegistrationSyNQuick.sh -d 3  -f $4 -m $FILE2  -o ToMNI_${FILE2} 
done


#Step3:FINAL TBSS_NON_FA step (programmed in a different script)
echo "

ANTs processing finished, now run drigo_tbss_non_FA_ants_Step2.sh for non_FA fsl procedure...

"



