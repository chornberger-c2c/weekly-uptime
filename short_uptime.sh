#!/bin/bash 
# create a nice status line used by screen, by CHO

echo -n $(uptime | awk '{gsub(/,/,"") ; printf  $1 " | up " $3 " " $4 " " ; if ($5 ~ /:/ ) printf  $5; printf " | load "; printf $(NF-2) " " $(NF-1) " " $NF}')
echo -n " |" $(free -h| awk '/cache:/{print "free " $4}')
echo -n " |" $(df -h|awk '/root/{print "disk " $5}')

#old rule for uptime, buggy columns were called
#echo -n $(uptime | awk '{gsub(/,/,"") ; print  $1 " | up " $3 " " $4 " " $5 " | load: " $10 " " $11 " "$12}')
