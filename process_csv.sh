#!/bin/bash

#processes the csv imported table into the appropriate recrods
if [ $1 == "-h" ]; then
  printf "Usage <Password> <database> <CSV table>\n"
  printf "note escape special characters in password\n"
  return
fi
    
    
# eval "mysql -u root -p'$1' $2 -e \"Insert into $2.macaddr2 (M1, M2, M3, M4, M5, M6, value)
#                      (SELECT CONVERT(SM1, unsigned int),
#                      CONVERT(SM2, unsigned int), CONVERT(SM3, unsigned int), CONVERT(SM4, unsigned int), CONVERT(SM5, unsigned int) ,
#                      CONVERT(SM6, unsigned int), concat(SM1, '.', SM2, '.',SM3, '.',SM4, '.',SM5, '.' ,SM6) FROM $2.CSV);\"" 
#  eval "mysql -u root -p'$1' $2 -e \"Insert into $2.macaddr2 (M1, M2, M3, M4, M5, M6, value)
#                      (SELECT CONVERT(DM1, unsigned int),
#                      CONVERT(DM2, unsigned int), CONVERT(DM3, unsigned int), CONVERT(DM4, unsigned int), CONVERT(DM5, unsigned int) ,
#                      CONVERT(DM6, unsigned int), concat(DM1,  '.',DM2,  '.',DM3,  '.',DM4,  '.',DM5,  '.', DM6) FROM $2.CSV);\"" 
#                      
# 
#                      
# eval "mysql -u root -p'$1' $2 -e \"ALTER TABLE $2.macaddr2 
#                  ADD INDEX M (M1 ASC, M2 ASC, M3 ASC, M4 ASC, M5 ASC, M6 ASC)\""
#
# eval "mysql -u root -p'$1' $2 -e \"insert into $2.macaddr(M1, M2, M3, M4, M5, M6, value)
#                     SELECT DISTINCT M1, M2, M3, M4, M5, M6, value
#                    FROM $2.macaddr2\""
                    
  #remove another null mac address
#   eval "mysql -u root -p'$1' $2 -e \"delete from $2.macaddr
#                       where M1=0 and M2 =0 and M3=0 and M4=0 and M5=0 and M6=0 and idMac >1\""
#   eval "mysql -u root -p'$1' $2 -e \"drop table $2.macaddr2\""
# eval "mysql -u root -p'$1' $2 -e \"ALTER TABLE $2.macaddr
#                  ADD INDEX M (M1 ASC, M2 ASC, M3 ASC, M4 ASC, M5 ASC, M6 ASC)\""

               
#               
#   eval "mysql -u root -p'$1' $2 -e \"Insert into $2.ipaddr2 (IP1, IP2, IP3, IP4, value)
#                      (SELECT CONVERT(SIP1, unsigned int),
#                      CONVERT(SIP2, unsigned int), CONVERT(SIP3, unsigned int), CONVERT(SIP4, unsigned int),
#                       concat(SIP1, '.', SIP2, '.',SIP3, '.',SIP4) FROM $2.CSV);\"" 
#                      
#  eval "mysql -u root -p'$1' $2 -e \"Insert into $2.ipaddr2 (IP1, IP2, IP3, IP4, value)
#                      (SELECT CONVERT(DIP1, unsigned int),
#                      CONVERT(DIP2, unsigned int), CONVERT(DIP3, unsigned int), CONVERT(DIP4, unsigned int),
#                       concat(DIP1, '.', DIP2, '.',DIP3, '.',DIP4) FROM $2.CSV);\"" 
                      
#                      
 #eval "mysql -u root -p'$1' $2 -e \"ALTER TABLE $2.ipaddr2 
 #                 ADD INDEX P (IP1 ASC, IP2 ASC, IP3 ASC, IP4 ASC)\""
#
# eval "mysql -u root -p'$1' $2 -e \"insert into $2.ipaddr(IP1, IP2, IP3, IP4, value)
#                     SELECT DISTINCT IP1, IP2, IP3, IP4,value
#                    FROM $2.ipaddr2\""
                    
  #remove another null address
  # eval "mysql -u root -p'$1' $2 -e \"delete from $2.ipaddr
      #                 where IP1=0 and IP2 =0 and IP3=0 and IP4=0 and idIPAddr >1\""
  # eval "mysql -u root -p'$1' $2 -e \"drop table $2.ipaddr2\""    
  
 # eval "mysql -u root -p'$1' $2 -e \"ALTER TABLE $2.ipaddr 
 #                ADD INDEX P (IP1 ASC, IP2 ASC, IP3 ASC, IP4 ASC)\""                                         
  INSERT_PACKETS_QUERY="Insert into $2.packets(time, macSrc, macDst, vlanTag, ethType, ipSrc, 
                                                  ipDst, IpProto, portSrc, portDst, ipTos, SYN, ACK, FIN, RES, Flow)  
 	                      SELECT  time + time_u/1000000 as time, 
                                MAC1.idMac as macSrc, 
                                MAC2.idMac as macDst,  
                                conv(VlanTag_X, 16, 10) as vlanTag,
                                conv(EthType_X, 16, 10) as ethType,
                                TIP1.idIPAddr as ipSrc,  
                                TIP2.idIPAddr as ipDst, 
                                IPProto, 
                                SrcPort, 
                                DstPort, 
                                IPTos, 
                                SYN,
                                ACK , 
                                FIN, 
                                RES, 
                                1  
                      FROM $2.CSV
                      inner join $2.macaddr as MAC1
                      	on 	CSV.SM1 = MAC1.M1 and  
                        		CSV.SM2 = MAC1.M2 and  
                            CSV.SM3 = MAC1.M3 and 
                        		CSV.SM4 = MAC1.M4 and   
                            CSV.SM5 = MAC1.M5 and   
                            CSV.SM6 = MAC1.M6  
                      inner join $2.macaddr as MAC2
                      	on 	CSV.DM1 = MAC2.M1 and
                            CSV.DM2 = MAC2.M2 and
                            CSV.DM3 = MAC2.M3 and 
                            CSV.DM4 = MAC2.M4 and
                            CSV.DM5 = MAC2.M5 and
                            CSV.DM6 = MAC2.M6  
                      inner join $2.ipaddr as TIP1
                        on 	CSV.SIP1 = TIP1.IP1 and
                            CSV.SIP2 = TIP1.IP2 and
                            CSV.SIP3 = TIP1.IP3 and 
                            CSV.SIP4 = TIP1.IP4 
                      inner join $2.ipaddr as TIP2
                        on 	CSV.DIP1 = TIP2.IP1 and
                            CSV.DIP2 = TIP2.IP2 and
                            CSV.DIP3 = TIP2.IP3 and 
                            CSV.DIP4 = TIP2.IP4 ;"
  


  eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_PACKETS_QUERY")


 

