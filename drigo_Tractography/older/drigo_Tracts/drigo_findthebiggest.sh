#!/bin/bash

#Rodrigo Perea
#rperea@kumc.edu (alternative email grandrigo@gmail.com)
#PLEASE ADD DESCRIPTION HERE:!!!!!!
#
#
#THIS SCRIPT WAS CREATED UNDER bash version 3.2 unders OSX 10.7. To check your bash version,
#enter bash --version
#Any questions please feel free to contact me at the email provided above.


SOURCE=$( pwd )

#Checking what you are doing.....

function help {
    
    echo "Instructions to be entered here.... 
        \$1 should be the start of the HSC number...
         \$2 will be the inside folder where the tractography took place (e.g. L-Thalamus-* )
"
    exit

}
if  [ $1 = "--help" ] ; then
    help
fi
    
if [ -z $2 ] ; then 
    echo "Invalid 2nd argument...please check!
"
help
fi

for DIR in  $(ls -d $1* ) ;
do
    DIRtemp=$(basename $DIR)
    DIRA=${DIRtemp/.bedpostX}  ##DIRA is 11969_001_01
                               ##DIR is 11969_001_01.bedpostX
    echo "In directory $DIR"
    echo "DIRA is $DIRA"
    echo "DIR is $DIR"
done