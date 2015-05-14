#!/bin/sh

#   tbss_4_prestats - post-registration processing
#   Modified for the Ants procesing tool!

Usage() {
    cat <<EOF

Usage: tbss_4_prestats <threshold>

The normal recommendation for <threshold> is 0.2
Use the second argument to stat your "all_FA" image! 

EOF
    exit 1
}

[ "$2" = "" ] && Usage

echo [`date`] [`hostname`] [`uname -a`] [`pwd`] [$0 $@] >> .tbsslog

thresh=$1

cd stats

echo "creating skeleton mask using threshold $thresh"
echo $thresh > thresh.txt
${FSLDIR}/bin/fslmaths mean_FA_skeleton -thr $thresh -bin mean_FA_skeleton_mask

echo "creating skeleton distancemap (for use in projection search)"
${FSLDIR}/bin/fslmaths mean_FA_mask -mul -1 -add 1 -add mean_FA_skeleton_mask mean_FA_skeleton_mask_dst
${FSLDIR}/bin/distancemap -i mean_FA_skeleton_mask_dst -o mean_FA_skeleton_mask_dst

echo "projecting all FA data onto skeleton"
${FSLDIR}/bin/tbss_skeleton -i mean_FA -p $thresh mean_FA_skeleton_mask_dst ${FSLDIR}/data/standard/LowerCingulum_1mm $2 all_FA_skeletonised

echo ""
echo "now run stats - for example:"
echo "randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2 -V"
echo "(after generating design.mat and design.con)"

