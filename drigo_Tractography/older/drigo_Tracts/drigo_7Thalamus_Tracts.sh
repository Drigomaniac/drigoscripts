#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#PLEASE ADD DESCRIPTION HERE:!!!!!!
#
#
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.



#THIS SHOULD BE RUN ONCE THE 30 Parcelattions were computed using the drigo_TractThalamus.sh script.....


SOURCE=$( pwd )

#Checking what you are doing.....
if  [ $1 = "--help" ] ; then
    echo "Instructions to be entered here....
\$1 should be the start of the HSC number...
"
    exit
fi


#DECLARING OTHER IMPORTANT VARIABLES
TT="THAL_TRAC"
SEVEN="7RegionThalamus"

#Designate each Cortical Segmentaion values..
CINGU="L-Cingulate.nii.gz"
OCCI="L-Occipital.nii.gz"
PARIE="L-Parietal.nii.gz"
POCE="L-PostCentral.nii.gz"
PRECE="L-PreCentral.nii.gz"
PREFO="L-PreFrontal.nii.gz"
TEMPO="L-Temporal.nii.gz"



#Declaring each 7 regions with its corresponding tracts... MAKE SURE THEY ARE IN ALPHABETICAL ORDER OR HOWEVER THE OS works...
declare -a CINGULATE=( L-CauAntCing.nii.gz  L-IsthCing.nii.gz L-PostCing.nii.gz L-RosAntCing.nii.gz)
declare -a OCCIPITAL=(  L-Cuneus.nii.gz L-LatOcc.nii.gz L-Lingual.nii.gz )
declare -a PARIETAL=( L-InfPar.nii.gz L-PreCuneus.nii.gz  L-SupPar.nii.gz L-SupraMarg.nii.gz )
declare -a POSTCENTRAL=( L-PostCentral.nii.gz )
declare -a PRECENTRAL=( L-ParaCentral.nii.gz L-PreCentral.nii.gz )
declare -a PREFRONTAL=( L-CauMiddFr.nii.gz L-FrPole.nii.gz  L-Insula.nii.gz L-LatOrbFr.nii.gz L-MedOrbFr.nii.gz L-ParPerCu.nii.gz L-ParsTriang.nii.gz  L-RosMidFr.nii.gz L-SupFr.nii.gz )
declare -a TEMPORAL=(  L-Entho.nii.gz  L-Fusi.nii.gz  L-InfTemp.nii.gz L-MidTemp.nii.gz L-ParaHipp.nii.gz L-SupTemp.nii.gz L-TempPole.nii.gz )




for DIR in  $(ls -d $1* ) ;
do
    
    echo "In directory  $DIR..."

    DIRtemp=$(basename $DIR)
    DIRA=${DIRtemp/.bedpostX}
 


    #Making a 7regions* folder...
    mkdir -p $DIR/$SEVEN


    #FOR LOOP FOR ADDING THE CINGULATE ARRAY INTO...
#    counter=0
#    for FILE in $(ls $DIR/$TT/*.gz ) ;
#    do
#	BFILE=$(basename $FILE )
#	COMPARATE=${CINGULATE[(($counter))]}	
#	if [ $BFILE == $COMPARATE ]; then
#	    echo "Comparate is $COMPARATE and counter is $counter  "
#	    if [ $counter == 0 ]; then
#		cp $FILE $DIR/$SEVEN/$CINGU
#	    else
#		fslmaths $DIR/$SEVEN/$CINGU -add $FILE $DIR/$SEVEN/$CINGU
#	    fi
#		counter=$((counter+1))
#	fi
#    done

    #FOR LOOP FOR ADDING THE OCCIPITAL  ARRAY INTO...
#    counter=0
#    for FILE in $(ls $DIR/$TT/*.gz ) ;
#    do
#	BFILE=$(basename $FILE )
#	COMPARATE=${OCCIPITAL[(($counter))]}	
#	if [ $BFILE == $COMPARATE ]; then
#	   echo "Comparate is $COMPARATE and counter is $counter  "
#	    if [ $counter == 0 ]; then
#		cp $FILE $DIR/$SEVEN/$OCCI
#	    else
#		fslmaths $DIR/$SEVEN/$OCCI -add $FILE $DIR/$SEVEN/$OCCI
#	    fi
#		counter=$((counter+1))
#	fi
#    done



    #FOR LOOP FOR ADDING THE PARIETAL ARRAY INTO...
#    counter=0
#    for FILE in $(ls $DIR/$TT/*.gz ) ;
#    do
#	BFILE=$(basename $FILE )
#	COMPARATE=${PARIETAL[(($counter))]}	
#	if [ $BFILE == $COMPARATE ]; then
#	    echo "Comparate is $COMPARATE and counter is $counter  "
#	    if [ $counter == 0 ]; then
#		cp $FILE $DIR/$SEVEN/$PARIE
#	    else
#		fslmaths $DIR/$SEVEN/$PARIE -add $FILE $DIR/$SEVEN/$PARIE
#	    fi
#		counter=$((counter+1))
#	fi
#   done



    #FOR LOOP FOR ADDING THE POSTCENTRAL ARRAY INTO...
#    counter=0
#    for FILE in $(ls $DIR/$TT/*.gz ) ;
#    do
#	BFILE=$(basename $FILE )
#	COMPARATE=${POSTCENTRAL[(($counter))]}	
#	if [ $BFILE == $COMPARATE ]; then
#	    echo "Comparate is $COMPARATE and counter is $counter  "
#	    if [ $counter == 0 ]; then
#		cp $FILE $DIR/$SEVEN/$POCE
#	    else
#		fslmaths $DIR/$SEVEN/$POCE -add $FILE $DIR/$SEVEN/$POCE
#	    fi
#		counter=$((counter+1))
#	fi
#   done



    #FOR LOOP FOR ADDING THE PRECENTRAL ARRAY INTO...
#    counter=0
#   for FILE in $(ls $DIR/$TT/*.gz ) ;
#   do
#	BFILE=$(basename $FILE )
#	COMPARATE=${PRECENTRAL[(($counter))]}	
#	if [ $BFILE == $COMPARATE ]; then
#	   echo "Comparate is $COMPARATE and counter is $counter  "
#	    if [ $counter == 0 ]; then
#		cp $FILE $DIR/$SEVEN/$PRECE
#	    else
#		fslmaths $DIR/$SEVEN/$PRECE -add $FILE $DIR/$SEVEN/$PRECE
#	    fi
#		counter=$((counter+1))
#	fi
 #  done
   
   
   
    #FOR LOOP FOR ADDING THE PREFORNTAL ARRAY INTO...
    counter=0
    for FILE in $(ls $DIR/$TT/*.gz ) ;
    do
	BFILE=$(basename $FILE )
	COMPARATE=${PREFRONTAL[(($counter))]}	
	if [ $BFILE == $COMPARATE ]; then
	    echo "Comparate is $COMPARATE and counter is $counter  "
	    if [ $counter == 0 ]; then
		cp $FILE $DIR/$SEVEN/$PREFO
	    else
		fslmaths $DIR/$SEVEN/$PREFO -add $FILE $DIR/$SEVEN/$PREFO
	    fi
	    counter=$((counter+1))
	fi
    done
    
    
    #FOR LOOP FOR ADDING THE TEMPORAL ARRAY INTO...
#    counter=0
#    for FILE in $(ls $DIR/$TT/*.gz ) ;
##    do
#	BFILE=$(basename $FILE )
#	COMPARATE=${TEMPORAL[(($counter))]}	
#	if [ $BFILE == $COMPARATE ]; then
#	    echo "Comparate is $COMPARATE and counter is $counter  "
#	    if [ $counter == 0 ]; then
#		cp $FILE $DIR/$SEVEN/$TEMPO
#	    else
#		fslmaths $DIR/$SEVEN/$TEMPO -add $FILE $DIR/$SEVEN/$TEMPO
#	    fi
#	    counter=$((counter+1))
#	fi
#    done

done
