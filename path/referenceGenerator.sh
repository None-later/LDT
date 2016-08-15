#!/bin/bash 
cd ~/git/LDT/
CURRCOUNT=`cat ~/git/LDT/refcount`
CURRCOUNT=$(expr $CURRCOUNT + 1)
#echo "LREF_${CURRCOUNT}"
printf "LREF_%06d" ${CURRCOUNT}
echo $CURRCOUNT > ~/git/LDT/refcount

