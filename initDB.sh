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
  PRIMARY KEY (idPackets),
  KEY idMac_idx (macSrc),
  KEY vlanTag_idx (vlanTag),
  KEY 4_idx (ethType),
  KEY 5_idx (ipSrc),
  KEY 6_idx (ipDst),
  KEY 7_idx (ipProto),
  KEY idMac_idx1 (macDst),
  KEY 7_idx1 (Flow),
  KEY flow_gen (portSrc,portDst,ipSrc,ipDst,time),
  KEY time_i (Flow,time),
  KEY time_s (time),
  CONSTRAINT F2 FOREIGN KEY (macDst) REFERENCES $2.macaddr (idMac) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT F3 FOREIGN KEY (ipSrc) REFERENCES $2.ipaddr (idIPAddr) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT F4 FOREIGN KEY (ipDst) REFERENCES $2.ipaddr (idIPAddr) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT F5 FOREIGN KEY (Flow) REFERENCES $2.flows (idFlows) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT F1 FOREIGN KEY (macSrc) REFERENCES $2.macaddr (idMac) ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE=InnoDB AUTO_INCREMENT=8650621 DEFAULT CHARSET=utf8;"
    
               
                      
CREATE_MAC_TABLE="CREATE TABLE $2.macaddr (
  idMac int(11) unsigned NOT NULL AUTO_INCREMENT,
  M1 int(11) unsigned NOT NULL,
  M2 int(11) unsigned NOT NULL,
  M3 int(11) unsigned NOT NULL,
  M4 int(11) unsigned NOT NULL,
  M5 int(11) unsigned NOT NULL,
  M6 int(11) unsigned NOT NULL,
  PRIMARY KEY (idMac), 
    KEY F2 (M1,M2,M3,M4,M5,M6)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
      
      


                    

CREATE_IP_TABLE="CREATE TABLE $2.ipaddr (
  idIPAddr int(11)unsigned NOT NULL AUTO_INCREMENT,
  IP1 int(11) unsigned NOT NULL,
  IP2 int(11) unsigned NOT NULL,
  IP3 int(11) unsigned NOT NULL,
  IP4 int(11) unsigned NOT NULL,
  PRIMARY KEY (idIPAddr), 
   KEY F2 (IP1,IP2,IP3,IP4)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
      
      
CREATE_FLOW_TABLE="CREATE TABLE $2.flows (
  idFlows int(11) unsigned NOT NULL AUTO_INCREMENT,
  ipSrc int(11) unsigned NOT NULL,
  ipDst int(11) unsigned NOT NULL,
  portSrc int(11) unsigned NOT NULL,
  portDst int(11) unsigned NOT NULL,
  PRIMARY KEY (idFlows)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
      
    

     
INSERT_NULL_IP_QUERY="insert into $2.ipaddr (idIPAddr, IP1, IP2, IP3, IP4)
                  values (1, 0, 0, 0, 0)";
INSERT_NULL_MAC_QUERY="insert into $2.macaddr (idMac, M1, M2, M3, M4, M5, M6)
                  values (1, 0, 0, 0, 0,0, 0)";
INSERT_NULL_FLOW_QUERY="insert into $2.flows (idFlows, ipSrc,ipDst, portSrc,portDst)
                  values (1, 1, 1, 0, 0)";
                  
#eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_MAC_TABLE")     
#eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_IP_TABLE")   
#eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_FLOW_TABLE") 
#eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_NULL_MAC_QUERY")
#eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_NULL_IP_QUERY")
#eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_NULL_FLOW_QUERY")

eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_TABLE_QUERY")    
 
fi