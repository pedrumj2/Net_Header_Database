#!/bin/bash

#deletes all tables from database

if [ $1 == "-h" ]; then
  printf "Usage <Password> <database> <CSV table>\n"
  printf "note escape special characters in password\n"
else
    
  DROP_PACKET_QUERY="DROP TABLE if exists $2.packets"
  DROP_MAC_QUERY="DROP TABLE if exists $2.macaddr"
  DROP_IP_QUERY="DROP TABLE if exists $2.ipaddr"

  DROP_FLOWS_QUERY="DROP TABLE if exists $2.flows"
               eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$DROP_PACKET_QUERY")       
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$DROP_MAC_QUERY")
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$DROP_IP_QUERY")    

  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$DROP_FLOWS_QUERY") 
  
fi