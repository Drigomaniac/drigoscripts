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

This script will generate the *.qsub files that are necessary to submit into the cluster (for BEDPOST).
To run this script, it is recommended to run it from the folder containing the files you want to submit in the cluster.
To run, please type -run  
"
    exit
fi


if [ $1 = '-run' ] ; then
    
#Assigning the foldername to $FOLDER
    IMAGE=$1
    
    echo "What suffix do the folders have(e.g. *BEDPOST will be default if you hit enter)?"
    read -e ITYPE
    echo "Where are the images located (Type the folder location or Enter to use current location)?"
    read -e PROJECT
    
#If LOCATION is a null string...allocated as the pwd directory....

    if [ -z $ITYPE ]; then
	ITYPE='BEDPOST'
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

    for DIR in $( ls -d $PROJECT/*$ITYPE/ ) ; 
    do
#Generating the pbs_submit file....
	echo "in $DIR..."

	DIRNAME=$( basename $DIR )
	DIRQSUB=${DIRNAME}.qsub
	#Check first if the files exists, if so, then delete it.
	if [ -f $QSUBS/$DIRQSUB ] ; then
	    rm $QSUBS/$DIRQSUB 
	fi
	
	echo "#PBS -N $DIRQSUB
#PBS -l nodes=1:ppn=2
#PBS -q default      
#PBS -M rperea@ittc.ku.edu
#PBS -m abe
#PBS -j oe                                                  

$FSL_DIR/bin/bedpostx $DIR | tee $QSUBS/tee_$DIRQSUB " >> $QSUBS/$DIRQSUB.qsub
	
	
	echo "$DIRQSUB has been stored in $QSUBS.."
    done


else
    echo " Incorrect arguments. Please type --help for help. "    
fi
