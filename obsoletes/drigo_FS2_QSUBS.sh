#!/bin/bash                                                                                                
# read DIREC                                                                                               
PWD=$( pwd )
SOURCE=$1
GROUPLIST="long_non_afil"
EXPECTED_ARGS=1

#Checking for one single argument
if [ $# -eq 0 ] ; then
echo "Type --help for help"

exit

fi
 

if [ $1 = "--help" ]; then
    echo"

This script will generate the *.qsub files that are necessary to submit into the cluster after recon-all has been submitted and is ready to .
To run this script, it is recommended to run it from the folder containing the files you want to submit in the cluster.
To run, please type -run  
"
    exit
fi


if [ $1 = '-run' ] ; then
    
#Assigning the foldername to $FOLDER
    IMAGE=$1
    
    echo "What ending folder name do they have in common? (e.g. WU_118323_MPRAGE, then put MPRAGE. If ending is MPRAGE, you could also hit enter)?"
    read -e ITYPE
    echo "Where are the images located (Type the folder location or Enter to use current location)?"
    read -e PROJECT
    
#If LOCATION is a null string...allocated as the pwd directory....

    if [ -z $ITYPE ]; then
	ITYPE='MPRAGE'
    fi
    if [ -z $LOCATION  ]; then
	LOCATION=$PWD
    fi
    
    
    if [ -z $PROJECT ] ; then
	PROJECT=$PWD
	
    fi
    
    echo "QSUBS directory with all the *.qsubs will be generated in $PROJECT/QSUBS/* "
    
    QSUBS=$PROJECT/QSUBS
    mkdir -p $PROJECT/QSUBS

    for DIREC in $( ls -d *$ITYPE ) ; 
    do
#Generating the pbs_submit file....




	#Check first if the files exists, if so, then delete it.
	if [ -f $QSUBS/${DIREC/$ITYPE}.qsub ] ; then
	    rm $QSUBS/${DIREC/$ITYPE}.qsub 
	fi
	
	echo "
#PBS -N ${DIREC/$ITYPE}
#PBS -l nodes=1:ppn=2
#PBS -q default      
#PBS -j oe                                                  

$FREESURFER_HOME/bin/recon-all  -autorecon2-cp -autorecon3 -sd $PROJECT -subjid $PROJECT/$DIREC  | tee $QSUBS/tee_rsEDIT_${DIREC/$ITYPE} " >> $QSUBS/${DIREC/$ITYPE}.qsub
	
	
	echo "${DIREC/$ITYPE}.qsub has been stored in $QSUBS.."
    done


else
    echo " Incorrect arguments. Please type --help for help. "    
fi
