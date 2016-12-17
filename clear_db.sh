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
   CREATE_TABLE_QUERY="CREATE TABLE IF NOT EXISTS mydb.packets (
                        idPackets INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                        time DOUBLE NULL DEFAULT NULL,
                        macSrc INT(10) UNSIGNED NOT NULL,
                        macDst INT(10) UNSIGNED NOT NULL,
                        vlanTag INT UNSIGNED NOT NULL,
                        ethType INT UNSIGNED NOT NULL,
                        ipSrc INT(10) UNSIGNED NOT NULL,
                        ipDst INT(10) UNSIGNED NOT NULL,
                        ipProto INT UNSIGNED NOT NULL,
                        portSrc INT(11) NOT NULL,
                        portDst INT(11) NOT NULL,
                        ipTos INT(10) UNSIGNED NOT NULL,
                        SYN TINYINT(1) NULL DEFAULT NULL,
                        ACK TINYINT(1) NULL DEFAULT NULL,
                        FIN TINYINT(1) NULL DEFAULT NULL,
                        RES TINYINT(1) NULL DEFAULT NULL,
                        Flow INT UNSIGNED NOT NULL,
                        PRIMARY KEY (idPackets),
                        UNIQUE INDEX idPackets_UNIQUE (idPackets ASC),
                        INDEX idMac_idx (macSrc ASC),
                        INDEX vlanTag_idx (vlanTag ASC),
                        INDEX 4_idx (ethType ASC),
                        INDEX 5_idx (ipSrc ASC),
                        INDEX 6_idx (ipDst ASC),
                        INDEX 7_idx (ipProto ASC),
                        INDEX idMac_idx1 (macDst ASC),
                        INDEX 7_idx1 (Flow ASC),
                        INDEX flow_gen (portSrc ASC, portDst ASC, ipSrc ASC, ipDst ASC, time ASC),
                        CONSTRAINT \\\`1\\\`
                          FOREIGN KEY (macSrc)
                          REFERENCES mydb.macaddr (idMac)
                          ON DELETE CASCADE
                          ON UPDATE NO ACTION,
                        CONSTRAINT \\\`2\\\`
                          FOREIGN KEY (macDst)
                          REFERENCES mydb.macaddr (idMac)
                          ON DELETE CASCADE
                          ON UPDATE NO ACTION,
                        CONSTRAINT \\\`5\\\`
                          FOREIGN KEY (ipSrc)
                          REFERENCES mydb.ipaddr (idIPAddr)
                          ON DELETE CASCADE
                          ON UPDATE NO ACTION,
                        CONSTRAINT \\\`6\\\`
                          FOREIGN KEY (ipDst)
                          REFERENCES mydb.ipaddr (idIPAddr)
                          ON DELETE CASCADE
                          ON UPDATE NO ACTION,
                        CONSTRAINT \\\`7\\\`
                          FOREIGN KEY (Flow)
                          REFERENCES mydb.flows (idFlows)
                          ON DELETE NO ACTION
                          ON UPDATE NO ACTION)
                      ENGINE = InnoDB
                      DEFAULT CHARACTER SET = utf8";
                    
                    
     
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