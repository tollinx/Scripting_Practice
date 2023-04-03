#Tony Lin
#tolllin
#113283910

#!/bin/bash

#Specify dir/ path
if [ $# -ne 1 ]; then
  echo "input directory is missing"
  exit 1
fi

#Check if its a valid directory
if [ ! -d "$1" ]; then
  echo "the directory does not exist"
  exit 1
fi

cd "$1"

#Printing
echo "Current date and time: $(date +%D\ %T)"
echo -n "Current directory is: "
pwd
echo
echo "--- 10 most recently modified directories ---"
ls -lt | grep '^d' | head -n 10 #Sorts everything by most recent, filters out non-directories, and then 
echo
echo "--- 6 largest files ---"
ls -Slh | grep -v '^d' | tail -n 6 
echo
echo "======================================================================"

