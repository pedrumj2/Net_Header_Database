#!/bin/bash

#creates empty tables for database.

if [ $1 == "-h" ]; then
  printf "Usage <Password> <database> <CSV table>\n"
  printf "note escape special characters in password\n"
else
    
    


CREATE_TABLE_QUERY="CREATE TABLE $2.packets (
  idPackets int(10) unsigned NOT NULL AUTO_INCREMENT,
  time double DEFAULT NULL,
  macSrc int(10) unsigned NOT NULL,
  macDst int(10) unsigned NOT NULL,
  vlanTag int(10) unsigned NOT NULL,
  ethType int(10) unsigned NOT NULL,
  ipSrc int(10) unsigned NOT NULL,
  ipDst int(10) unsigned NOT NULL,
  ipProto int(10) unsigned NOT NULL,
  portSrc int(11) NOT NULL,
  portDst int(11) NOT NULL,
  ipTos int(10) unsigned NOT NULL,
  SYN tinyint(1) DEFAULT NULL,
  ACK tinyint(1) DEFAULT NULL,
  FIN tinyint(1) DEFAULT NULL,
  RES tinyint(1) DEFAULT NULL,
  Flow int(10) unsigned NOT NULL,

  PRIMARY KEY (idPackets)
  ) ENGINE=InnoDB AUTO_INCREMENT=8650621 DEFAULT CHARSET=utf8;"
    
               
                      
CREATE_MAC_TABLE="CREATE TABLE $2.macaddr (
  idMac int(11) unsigned NOT NULL AUTO_INCREMENT,
  M1 int(11) unsigned NOT NULL,
  M2 int(11) unsigned NOT NULL,
  M3 int(11) unsigned NOT NULL,
  M4 int(11) unsigned NOT NULL,
  M5 int(11) unsigned NOT NULL,
  M6 int(11) unsigned NOT NULL,
  value char(30) NOT NULL,
  PRIMARY KEY (idMac)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
      
      
CREATE_MAC_TABLE2="CREATE TABLE $2.macaddr2 (
  idMac int(11) unsigned NOT NULL AUTO_INCREMENT,
  M1 int(11) unsigned NOT NULL,
  M2 int(11) unsigned NOT NULL,
  M3 int(11) unsigned NOT NULL,
  M4 int(11) unsigned NOT NULL,
  M5 int(11) unsigned NOT NULL,
  M6 int(11) unsigned NOT NULL,
  value char(30) NOT NULL,
  PRIMARY KEY (idMac)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
                   

CREATE_IP_TABLE="CREATE TABLE $2.ipaddr (
  idIPAddr int(11)unsigned NOT NULL AUTO_INCREMENT,
  IP1 int(11) unsigned NOT NULL,
  IP2 int(11) unsigned NOT NULL,
  IP3 int(11) unsigned NOT NULL,
  IP4 int(11) unsigned NOT NULL,
  value char(30) NOT NULL, 
  PRIMARY KEY (idIPAddr)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
      
      
CREATE_IP_TABLE2="CREATE TABLE $2.ipaddr2 (
  idIPAddr int(11)unsigned NOT NULL AUTO_INCREMENT,
  IP1 int(11) unsigned NOT NULL,
  IP2 int(11) unsigned NOT NULL,
  IP3 int(11) unsigned NOT NULL,
  IP4 int(11) unsigned NOT NULL,
  value char(30) NOT NULL, 
  PRIMARY KEY (idIPAddr)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
      
CREATE_FLOW_TABLE="CREATE TABLE $2.flows (
  idFlows int(11) unsigned NOT NULL AUTO_INCREMENT,
  ipSrc int(11) unsigned NOT NULL,
  ipDst int(11) unsigned NOT NULL,
  portSrc int(11) unsigned NOT NULL,
  portDst int(11) unsigned NOT NULL,
  startTime dateTime DEFAULT NULL, 
  endTime dateTime DEFAULT NULL, 
  PRIMARY KEY (idFlows), 
  INDEX F (ipSrc ASC, ipDst ASC, portSrc ASC, portDst ASC, endTime ASC, startTime ASC)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
      

     
INSERT_NULL_IP_QUERY="insert into $2.ipaddr (idIPAddr, IP1, IP2, IP3, IP4, value)
                  values (1, 0, 0, 0, 0, '0.0.0.0')";
INSERT_NULL_MAC_QUERY="insert into $2.macaddr (idMac, M1, M2, M3, M4, M5, M6, value) 
                        values (1, 0, 0, 0, 0,0, 0,  '0.0.0.0.0.0')";
INSERT_NULL_FLOW_QUERY="insert into $2.flows (idFlows, ipSrc,ipDst, portSrc,portDst, startTime, endTime)
                  values (1, 1, 1, 0, 0, from_unixtime(1487017060),from_unixtime(1487017060))";
                  
eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_MAC_TABLE")     
eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_IP_TABLE")   
eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_FLOW_TABLE") 
#
eval "mysql -u root -p'$1' $2 -e \"$INSERT_NULL_MAC_QUERY\"" 
eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_NULL_IP_QUERY")
eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_NULL_FLOW_QUERY")
eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_TABLE_QUERY")    

eval "mysql -u root -p'$1' $2 -e \"$CREATE_MAC_TABLE2\"" 
eval "mysql -u root -p'$1' $2 -e \"$CREATE_IP_TABLE2\"" 






fi