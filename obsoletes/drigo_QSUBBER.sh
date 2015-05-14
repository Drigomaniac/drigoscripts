#!/bin/bash                                                                                                
# read DIREC                                                                                               
PWD=$( pwd )
    for FILE in $( ls *.qsub ) ; 
    do
#Submitting all the jobs ending with *.qsub
	qsub $FILE
done
