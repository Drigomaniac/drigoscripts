#!/bin/bash

#Rodrigo Perea
#Created: 04 16 2013
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#PLEASE ADD DESCRIPTION HERE:!!!!!!
#This file will extract the necessary values for the simple response time 
#task giving in the fMRI. Type --help for more instructions. 
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version

#Any questions please feel free to contact me at the email provided above.


pwd=SOURCE


#INCLUDE VERY HANDY CALCULATER FOR SIMPLE COMMANDS:
cc(){ awk "BEGIN{ print $* }" ;}


#Checking what you are doing.....
if  [ $1 = "--help" ] ; then
    echo "To run, provide the simpleRT files as the first argument.
For example: drigo_SimpleRT_extraction.sh 11884_110_01_simpleRT.log
Additionally you could use the *simpleRT* for more than on file....


Provide the output file as the 2nd argument!"
    exit
fi

#INITIALZING THE OUTPUT VARIABLE
OUTFILE=RT_Simple_$(date +"%m_%d_%y_%T").txt
#OUTFILE=out.txt


#For each file, execute the following code...

echo -e "ID  \t MEAN(ms)   \t STDEV(ms)   \t ACC(%)   \t MEDIAN(ms) " >> $OUTFILE
for FILES in "$@"; do
    
#INITIALIZING temporal files...
    TEMP=sttemp.txt
    TEMP2=temp2.txt
    
    
#INITIALIZING VARIABLES with code "-4"
    MEAN_RES=-4
    STDEV_RES=-4
    RT_ACC=-4
    MEDIAN_RES=-4
    
#this two followed lines will keep alphanumerical values and remove all letters
#and "."
    FILE=$( ls $FILES | tr -d [:alpha:] )
    SBNAME=${FILE/./SimpleRT}
    SBNAME=${SBNAME/-/_}
#echo "In file: $FILES ..."
    
    
#Print only if the 3rd argument is a hit
    RESPONSE=$(awk '{ if ( $3 == "hit") print $5 }' $FILES) 
    RESPONSE_ALL=$( awk '{ if ($1 == "Picture" ) print $5}' $FILES )
#This will transpose RESPONSE so it can be used for STDEV...
    echo "$RESPONSE" >> $TEMP
    
    
    
    
#Find the STDEV of RESPONSE 
#TRY AND FAIL, check if there is at least a Picture row..
    CHECK=$(cat $FILES | grep Picture | wc -l )
    
    if  [ $CHECK -gt 0 ] ;
    then

        #FOR SOME REASON ALL THE ARE IN 10th of ms so I NEED TO DIVIDE BY 10!!

	MEAN_RES=$(awk '{sum+=$1} END {print sum/(10*NR)};' $TEMP )
	STDEV_RES=$(awk '{sum+=$1; xsq+=$1*$1; avgsq=(sum/NR)^2; } END {print  sqrt((xsq - NR*avgsq)/(NR-1))/10}' $TEMP ) 
	MEDIAN_RES=$(sort -n $TEMP | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/20; else print a[x-1]/10; }'  )
#Assing the number of Picture repetition (or tries) to get the accurate time
	NUM_PICS=$(cat $FILES | grep Picture | wc -l )
	NUM_HITS=$(cat $FILES | grep hit | wc -l )
	
#Calculating the accuracy using the simple cc
	RT_ACC=$( cc 100*$NUM_HITS/$NUM_PICS )
	
	
    fi
#Print out the values:
#echo " AVG_RES is: $AVG_RES
#STDEV_RES is: $STDEV_RES
#MEDIAN_RES is: $MEDIAN_RES
#RT_ACC is: $RT_ACC
    
    

#Format the print out for a better formatting....
    if [ $CHECK -gt 0 ] ; then
#	echo -e "  $(cc $SBNAME/10 ) \t \t $(cc $MEAN_RES/10 )  \t  \t $(cc $STDEV_RES/10 ) \t \t  $(cc $RT_ACC*100 ) \t \t  $(cc $MEDIAN_RES/10 )  " >> out.txt
	echo -e "  $SBNAME \t $MEAN_RES   \t  $STDEV_RES  \t   $RT_ACC  \t  $MEDIAN_RES  " >> $OUTFILE
    else
	echo -e " $SBNAME  \t  $MEAN_RES    \t $STDEV_RES \t   $RT_ACC \t $MEDIAN_RES  " >> $OUTFILE
	
    fi
    
#HERE WE CLEAR OUR TEMP FILE TO AVOID REPLICATION
    [[ -f $TEMP ]] && rm $TEMP
    [[ -f $TEMP2 ]] && rm $TEMP2

	
	
#
done










################################################
#USEFULE SCRIPTS....
#FOR LOOPS

#for FILE in $( ls  $SOURCE*$2*); 
# do
#    echo $FILE
#done


#IF STATEMENTS
#if [ something == ?? ] ; then
#elif 
#else
#fi

#DECLARING ARRAYS
# declare -a ARRAY=( s f g fdw da fd s )


#COUNTER AND COUNTER++
#counter=1
#counter=((counter++))
##################################################
