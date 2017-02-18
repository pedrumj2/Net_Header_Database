#!/bin/bash

#An auxillary script. Once the net_flow_gen package has been run the output needs to be modified
#in order to be usable for the net_con_count package. This script performs the adjustment
if [ "$#" -ne 2 ]; then
  printf "Usage <Password> <database>\n"
  exit
fi
    
    

#as part of the algorithm the flow lengths will over estimated by 60s. This will
#remove that effect
eval "mysql -u root -p'$1' $2 -e \"update $2.flows
                                  set endTime = date_sub(endTime, INTERVAL 1 minute)\""
#                                  
for some reason there are some nulls in the flows, they are removed here.
eval "mysql -u root -p'$1' $2 -e \"delete from $2.flows
                                   where (ipSrc =1 or ipDst =1 or portSrc =0 or portDst =0) and idFlows > 1\""
                                   
#the net_con_count package required a tag parameter
eval "mysql -u root -p'$1' $2 -e \"ALTER TABLE $2.flows
                                   ADD COLUMN tag CHAR(20) NOT NULL DEFAULT 'Normal' AFTER endTime\""
                                   
 
#indices are added as required by the net_con_count pacakge
eval "mysql -u root -p'$1' $2 -e \"ALTER TABLE $2.flows
                                  ADD INDEX count (ipDst ASC, startTime ASC);\""
                                                                                                       
#columns are named according to the net_con_count package convention
eval "mysql -u root -p'$1' $2 -e \"ALTER TABLE $2.flows
                         CHANGE COLUMN ipSrc source INT(11) UNSIGNED NOT NULL,  
                         CHANGE COLUMN ipDst dest INT(11) UNSIGNED NOT NULL ;\""    

    


    


    



    
 

 

