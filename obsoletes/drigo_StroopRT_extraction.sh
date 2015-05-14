#!/bin/bash

#Rodrigo Perea
#Created: 04 16 2013
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#PLEASE ADD DESCRIPTION HERE:!!!!!!
#This file will extract the necessary values for the simple Stroop task 
#task giving in the fMRI. Type --help for more instructions. 
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me.


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
OUTFILE=STROOP_$(date +"%m_%d_%y_%T").txt
#OUTFILE=out.txt


#For each file, execute the following code...

echo -e "FILENAME \t ID  \t MEAN_ALL(ms)   \t STDEV_ALL(ms)   \t ACC_ALL(%)   \t MEDIAN_ALL(ms)  \t <====>  \t MEAN_WC(ms)   \t STDEV_WC(ms)   \t ACC_WC(%)   \t MEDIAN_WC(ms)  \t <====> \t MEAN_WI(ms)   \t STDEV_WI(ms)   \t ACC_WI(%)   \t MEDIAN_WI(ms) \t <====>  \t MEAN_AC(ms)   \t STDEV_AC(ms)   \t ACC_AC(%)   \t MEDIAN_AC(ms) \t <====>  \t MEAN_AI(ms)   \t STDEV_AI(ms)   \t ACC_AI(%)   \t MEDIAN_AI(ms) " >> $OUTFILE
for FILES in "$@"; do
    
#INITIALIZING temporal files...
    HITS_ALL=hits.txt
    HITS_WC=hitsWC.txt
    HITS_WI=hitsWI.txt
    HITS_AC=hitsAC.txt
    HITS_AI=hitsAI.txt
    
#INITIALIZING VARIABLES with code "-4"
#MEAN, STDEV, ACCURACY and MEDIAN  
#WORD CONGRUENT/INCONGRUENT or ARROW CONGRUENT/INCONGRUENT cases
  
    ME_ALL=-4
    ST_ALL=-4
    ACC_ALL=-4
    MD_ALL=-4
    
    ME_WC=-4
    ST_WC=-4
    ACC_WC=-4
    MD_WC=-4
    
    ME_WI=-4
    ST_WI=-4
    ACC_WI=-4
    MD_WI=-4

    ME_AC=-4
    ST_AC=-4
    ACC_AC=-4
    MD_AC=-4

    ME_AI=-4
    ST_AI=-4
    ACC_AI=-4
    MD_AI=-4
#this two followed lines will keep alphanumerical values and remove all letters
#and "."
    FILE=$( ls $FILES | tr -d [:alpha:] )
    SBNAME=${FILE//.}
    SBNAME=${SBNAME/-/_}
    SBNAME=${SBNAME/_12/_Stroop12}
    
#Print only if the 3rd argument is a hit
    HITS_ALLt=$(awk '{ if ( $3 == "hit") print $5 }' $FILES) 
    HITS_WCt=$(awk '{ if (($3 == "hit") && ($2 == 2.1 || $2 ==4.1 )) print $5}' $FILES )
    HITS_WIt=$(awk '{ if (($3 == "hit") && ($2 == 1.1 || $2 ==3.1 )) print $5}' $FILES )
    HITS_ACt=$(awk '{ if (($3 == "hit") && ($2 == 2 || $2 == 4 )) print $5}' $FILES )
    HITS_AIt=$(awk '{ if (($3 == "hit") && ($2 == 1 || $2 == 3 )) print $5}' $FILES )
#This will transpose RESPONSE so it can be used for STDEV...
    echo "$HITS_ALLt" >> $HITS_ALL
    echo "$HITS_WCt" >> $HITS_WC
    echo "$HITS_WIt" >> $HITS_WI
    echo "$HITS_ACt" >> $HITS_AC
    echo "$HITS_AIt" >> $HITS_AI
    
#Find the STDEV of RESPONSE 
#TRY AND FAIL, check if there is at least a Picture row..
    CHECK=$(cat $FILES | grep hit | wc -l )
    
    if  [ $CHECK -gt 0 ] ;
    then

        #FOR SOME REASON ALL THE ARE IN 10th of ms so I NEED TO DIVIDE BY 10 each calculation!!
	ME_ALL=$(awk '{sum+=$1} END {print sum/(10*NR)};' $HITS_ALL )
	ST_ALL=$(awk '{sum+=$1; xsq+=$1*$1; avgsq=(sum/NR)^2; } END {print  sqrt((xsq - NR*avgsq)/(NR-1))/10}' $HITS_ALL ) 
	MD_ALL=$(sort -n $HITS_ALL | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/20; else print a[x-1]/10; }'  )

	ME_WC=$(awk '{sum+=$1} END {print sum/(10*NR)};' $HITS_WC )
	ST_WC=$(awk '{sum+=$1; xsq+=$1*$1; avgsq=(sum/NR)^2; } END {print  sqrt((xsq - NR*avgsq)/(NR-1))/10}' $HITS_WC ) 
	MD_WC=$(sort -n $HITS_WC | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/20; else print a[x-1]/10; }'  )

	ME_WI=$(awk '{sum+=$1} END {print sum/(10*NR)};' $HITS_WI )
	ST_WI=$(awk '{sum+=$1; xsq+=$1*$1; avgsq=(sum/NR)^2; } END {print  sqrt((xsq - NR*avgsq)/(NR-1))/10}' $HITS_WI ) 
	MD_WI=$(sort -n $HITS_WI | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/20; else print a[x-1]/10; }'  )

	ME_AC=$(awk '{sum+=$1} END {print sum/(10*NR)};' $HITS_AC )
	ST_AC=$(awk '{sum+=$1; xsq+=$1*$1; avgsq=(sum/NR)^2; } END {print  sqrt((xsq - NR*avgsq)/(NR-1))/10}' $HITS_AC ) 
	MD_AC=$(sort -n $HITS_AC | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/20; else print a[x-1]/10; }'  )

	ME_AI=$(awk '{sum+=$1} END {print sum/(10*NR)};' $HITS_AI )
	ST_AI=$(awk '{sum+=$1; xsq+=$1*$1; avgsq=(sum/NR)^2; } END {print  sqrt((xsq - NR*avgsq)/(NR-1))/10}' $HITS_AI ) 
	MD_AI=$(sort -n $HITS_AI | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/20; else print a[x-1]/10; }'  )




        #Calculating the accuracy using the simple cc
	NUM_PICS_ALL=$(awk '{ if ( $1 == "Picture" ) print $3}' $FILES  | wc -l )
	NUM_PICS_WC=$(awk '{ if ($2 == 2.1 || $2 ==4.1 ) print $3}' $FILES  | wc -l )
	NUM_PICS_WI=$(awk '{ if ($2 == 1.1 || $2 ==3.1 ) print $3}' $FILES  | wc -l )
	NUM_PICS_AC=$(awk '{ if ($2 == 2 || $2 ==4 ) print $3}' $FILES  | wc -l )
	NUM_PICS_AI=$(awk '{ if ($2 == 1 || $2 ==3 ) print $3}' $FILES  | wc -l )
	
	nHITS_ALL=$(cat $HITS_ALL | wc -l )
	nHITS_WC=$(cat $HITS_WC | wc -l)
	nHITS_WI=$(cat $HITS_WI | wc -l)
	nHITS_AC=$(cat $HITS_AC | wc -l)
	nHITS_AI=$(cat $HITS_AI | wc -l)
	

 
	ACC_ALL=$(cc 100*$nHITS_ALL/$NUM_PICS_ALL )
	ACC_WC=$(cc 100*$nHITS_WC/$NUM_PICS_WC )
	ACC_WI=$(cc 100*$nHITS_WI/$NUM_PICS_WI )
	ACC_AC=$(cc 100*$nHITS_AC/$NUM_PICS_AC )
	ACC_AI=$(cc 100*$nHITS_AI/$NUM_PICS_AI )
 
#HERE WE CLEAR OUR TEMP FILE TO AVOID REPLICATION
	[[ -f $HITS_ALL ]] && rm $HITS_ALL
	[[ -f $HITS_WC ]] && rm $HITS_WC
	[[ -f $HITS_WI ]] && rm $HITS_WI
	[[ -f $HITS_AC ]] && rm $HITS_AC
	[[ -f $HITS_AI ]] && rm $HITS_AI
        fi

	echo "In $FILES...."
    
    

#Format the print out for a better formatting....
echo -e "  $FILES \t $SBNAME \t $ME_ALL   \t  $ST_ALL  \t   $ACC_ALL  \t  $MD_ALL \t \t $ME_WC   \t  $ST_WC  \t   $ACC_WC  \t  $MD_WC \t \t $ME_WI   \t  $ST_WI  \t   $ACC_WI  \t  $MD_WI \t \t $ME_AC   \t  $ST_AC  \t   $ACC_AC  \t  $MD_AC \t \t $ME_AI   \t  $ST_AI  \t   $ACC_AI  \t  $MD_AI \t \t    " >> $OUTFILE

        

done






