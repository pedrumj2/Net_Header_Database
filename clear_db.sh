#!/bin/bash

#Deletes records from the existing database:
#1- Drops the packet table. The reason it drops the table is that there is normally alot of data in this
#  table so its just faster to drop it rather than deleting every record
#2- Recreates the packet table
#3- deletes all records from the mac address table
#4- deletes all records from the ip address table

if [ $1 == "-h" ]; then
  printf "Usage <Password> <database> <CSV table>\n"
  printf "note escape special characters in password\n"
else
    
    
   DEL_MAC_QUERY="delete from mydb.macaddr"
   DEL_IP_QUERY="delete from mydb.ipaddr"
   DROP_PACKET_QUERY="DROP TABLE if exists mydb.packets "
   CREATE_TABLE_QUERY="CREATE TABLE packets (
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
                        UNIQUE KEY idPackets_UNIQUE (idPackets),
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
                        CONSTRAINT 1 FOREIGN KEY (macSrc) REFERENCES macaddr (idMac) ON DELETE CASCADE ON UPDATE NO ACTION,
                        CONSTRAINT 2 FOREIGN KEY (macDst) REFERENCES macaddr (idMac) ON DELETE CASCADE ON UPDATE NO ACTION,
                        CONSTRAINT 5 FOREIGN KEY (ipSrc) REFERENCES ipaddr (idIPAddr) ON DELETE CASCADE ON UPDATE NO ACTION,
                        CONSTRAINT 6 FOREIGN KEY (ipDst) REFERENCES ipaddr (idIPAddr) ON DELETE CASCADE ON UPDATE NO ACTION,
                        CONSTRAINT 7 FOREIGN KEY (Flow) REFERENCES flows (idFlows) ON DELETE NO ACTION ON UPDATE NO ACTION
                      ) ENGINE=InnoDB AUTO_INCREMENT=8650621 DEFAULT CHARSET=utf8;
;
                    
                    
     
INSERT_NULL_IP_QUERY="insert into mydb.ipaddr (idIPAddr, IP1, IP2, IP3, IP4)
                  values (1, 0, 0, 0, 0)";
INSERT_NULL_MAC_QUERY="insert into mydb.macaddr (idMac, M1, M2, M3, M4, M5, M6)
                  values (1, 0, 0, 0, 0,0, 0)";
INSERT_NULL_FLOW_QUERY="insert into mydb.flows (idFlows, ipSrc,ipDst, portSrc,portDst)
                  values (1, 1, 1, 0, 0)";
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$DROP_PACKET_QUERY")
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$CREATE_TABLE_QUERY")    
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$DEL_MAC_QUERY")
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$DEL_IP_QUERY")
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$REMOVE_AI_IP_QUERY")
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_NULL_IP_QUERY")
  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_NULL_MAC_QUERY")
    eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_NULL_FLOW_QUERY")
      #   eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$ADD_AI_IP_QUERY")
   
   
   

 
fi