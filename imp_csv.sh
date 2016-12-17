#!/bin/bash

#this script imports the input CSV file into the database. Use the wrapper function to cal it
 
  NAME=$(basename $3);
  A=$(printf "mysql -u root -p'%s' %s -e \"CREATE TABLE IF NOT EXISTS %s(" $1 $2 $NAME)
    
 
  B=$(head -1 $3 | sed -e 's/,/\ VARCHAR(20),/g')
 
  C=$(printf  " VARCHAR(20));\"\n")

  eval  $A $B $C 
  
  
  
  A=$(printf "mysqlimport --local --ignore-lines=1 --fields-terminated-by=, -u root -p'%s' %s" $1 $2 )
  B=$(printf "%s\n"  $3)
  eval $A $B
 

 


