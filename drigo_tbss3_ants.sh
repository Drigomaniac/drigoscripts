#!/bin/sh

#   tbss_3_postreg - re-arranged to fit the Ants_tbss registration at KUADC...

mkdir -p ../stats
Usage() {
    echo " 

You only need one argument:

(Eg. -->  all_FAAnts (with all the merged ANTs procesed FA/(other diffusion) images...)


"
    exit 1
}

EOF

[ "$1" = "" ] && Usage




# create mean FA
echo "creating valid mask and mean FA"
$FSLDIR/bin/fslmaths $1 -max 0 -Tmin -bin mean_FA_mask -odt char
$FSLDIR/bin/fslmaths $1 -Tmean mean_FA
# create skeleton
    echo "skeletonising mean FA"
    $FSLDIR/bin/tbss_skeleton -i mean_FA -o mean_FA_skeleton

echo "now view mean_FA_skeleton to check whether the default threshold of 0.2 needs changing, when running:"
echo "Run drigo_tbss_4_prestats <threshold>"

