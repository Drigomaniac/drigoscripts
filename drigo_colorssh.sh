#!/bin/bash

function tabc {
NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"$NAME\""
}


for ARG in $*
do
    case "$ARG" in

        *kus-imaging)
            tabc "Ubuntu"
            ;;
        *hpc.quant.ku.edu)
            tabc "Red Sands"
	    ;;
	*kum-rhonea1)
	    tabc "Novel"
	    ;;
	*kus-imaging2)
	    tabc "Man Page"
	    ;;
	*ssh.ittc.ku.edu)
	    tabc "Pro"
	;;
	*xnat2)
	tabc "Oceanic"
    esac
done

ssh $*
# back to normal
tabc "Ocean"
