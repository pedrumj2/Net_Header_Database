#!/bin/bash

#Use this wrapper script to call other scripts in the directory. It retrieves information
#from the .config file.
#the format of the .config file should be as follows:
#Lines 1 and 2 are comments
#Line 3: PASS:###### (password)
#Line 4: DB:######## (database name)
#Line 5: Location:###### (CSV file location)
#Line 6: empty line (required)
if [ "$1" == "-h" ]; then
  printf "Check if .config file is set correctly"
else
  I=1
  cat .config |
  while read x; do

    if [ $I = 3 ]; then
  
      PASS=$(echo "$x" | cut -d ":" -f 2)
    
    elif [ $I == 4 ]; then
      DB=$(echo "$x" | cut -d ":" -f 2)
      
    echo "entering script\n"
    elif [ $I == 5 ]; then
      LOCATION=$(echo "$x" | cut -d ":" -f 2)
      printf "entering script\n"
      eval $(printf "./%s %s %s %s\n\n" $1 $PASS $DB $LOCATION)
    fi
    I=$((I+1))
  done
fi