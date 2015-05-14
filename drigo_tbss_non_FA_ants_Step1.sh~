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


#Step3:FINAL TBSS_NON_FA step
echo "merging all upsampled $ALTIM images into single 4D image"
${FSLDIR}/bin/fslmerge -t ../stats/all_$ALTIM `$FSLDIR/bin/imglob *_to_target_${ALTIM}.*`
cd ../stats
$FSLDIR/bin/fslmaths all_$ALTIM -mas mean_FA_mask all_$ALTIM

echo "projecting all_$ALTIM onto mean FA skeleton"
thresh=0.2
${FSLDIR}/bin/tbss_skeleton -i mean_FA -p $thresh mean_FA_skeleton_mask_dst ${FSLDIR}/data/standard/LowerCingulum_1mm all_FA all_${ALTIM}_skeletonised -a all_$ALTIM

echo "now run stats - for example:"
echo "randomise -i all_${ALTIM}_skeletonised -o tbss_$ALTIM -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2 -V"
echo "(after generating design.mat and design.con)"









#/////

if [ _$1 = _ ] ; then
    echo "Usage: tbss_non_FA <alternative-image-rootname>"
    echo "e.g.: tbss_non_FA L2"
    exit 1
else
    ALTIM=$1
fi

echo [`date`] [`hostname`] [`uname -a`] [`pwd`] [$0 $@] >> .tbsslog

best=`cat FA/best.msf`
echo "using pre-chosen registration target: $best"

echo "upsampling alternative images into standard space"
# re-create temporary analyze version of MNI152 for use by IRTK
cd FA
postaffine=""
if [ -f target_to_MNI152.mat ] ; then
    postaffine="--postmat=target_to_MNI152.mat"
fi
for f in `$FSLDIR/bin/imglob *_FA.*` ; do
    f=` echo $f | sed 's/_FA$//g'`
    echo $f
    $FSLDIR/bin/applywarp -i ../${ALTIM}/$f -o ${f}_to_target_${ALTIM} -r $FSLDIR/data/standard/FMRIB58_FA_1mm -w ${f}_FA_to_${best}_warp $postaffine
done

echo "merging all upsampled $ALTIM images into single 4D image"
${FSLDIR}/bin/fslmerge -t ../stats/all_$ALTIM `$FSLDIR/bin/imglob *_to_target_${ALTIM}.*`
cd ../stats
$FSLDIR/bin/fslmaths all_$ALTIM -mas mean_FA_mask all_$ALTIM

echo "projecting all_$ALTIM onto mean FA skeleton"
thresh=`cat thresh.txt`
${FSLDIR}/bin/tbss_skeleton -i mean_FA -p $thresh mean_FA_skeleton_mask_dst ${FSLDIR}/data/standard/LowerCingulum_1mm all_FA all_${ALTIM}_skeletonised -a all_$ALTIM

echo "now run stats - for example:"
echo "randomise -i all_${ALTIM}_skeletonised -o tbss_$ALTIM -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2 -V"
echo "(after generating design.mat and design.con)"

