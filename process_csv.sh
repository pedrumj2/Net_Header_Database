#!/bin/bash

#processes the csv imported table into the appropriate recrods
if [ $1 == "-h" ]; then
  printf "Usage <Password> <database> <CSV table>\n"
  printf "note escape special characters in password\n"
else
    
    
 
  COPY_MAC_QUERY_SRC="Insert ignore into $2.macaddr (M1, M2, M3, M4, M5, M6)
                      (SELECT distinct  CONVERT(SM1, unsigned int),
                      CONVERT(SM2, unsigned int), CONVERT(SM3, unsigned int), CONVERT(SM4, unsigned int), CONVERT(SM5, unsigned int) ,
                      CONVERT(SM6, unsigned int) FROM $2.CSV);"
  COPY_MAC_QUERY_DST="Insert ignore into $2.macaddr (M1, M2, M3, M4, M5, M6)
                      (SELECT distinct  CONVERT(DM1, unsigned int),
                      CONVERT(DM2, unsigned int), CONVERT(DM3, unsigned int), CONVERT(DM4, unsigned int), CONVERT(DM5, unsigned int) ,
                      CONVERT(DM6, unsigned int) FROM $2.CSV);"
  
  COPY_IP_QUERY_SRC="Insert ignore into $2.ipaddr (IP1, IP2, IP3, IP4) 
                      (SELECT distinct  CONVERT(SIP1, unsigned int),
                      CONVERT(SIP2, unsigned int), CONVERT(SIP3, unsigned int), CONVERT(SIP4, unsigned int) from $2.CSV);"
  COPY_IP_QUERY_DST="Insert ignore into $2.ipaddr (IP1, IP2, IP3, IP4) 
                      (SELECT distinct  CONVERT(DIP1, unsigned int),
                      CONVERT(DIP2, unsigned int), CONVERT(DIP3, unsigned int), CONVERT(DIP4, unsigned int) from $2.CSV);"
                      
                  
                      
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
  
  #eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$COPY_MAC_QUERY_SRC")
  #eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$COPY_MAC_QUERY_DST")
  
  
  #eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$COPY_IP_QUERY_SRC")
  #eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$COPY_IP_QUERY_DST")

   eval $(printf "mysql -u root -p'%s' -e \"%s\"\n" $1 "$INSERT_PACKETS_QUERY")
fi