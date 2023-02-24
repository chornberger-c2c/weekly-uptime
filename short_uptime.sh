#!/bin/bash 
# create a nice status line used by screen, by CHO

echo -n $(uptime | awk '{gsub(/,/,"") ; printf  $1 " | up " $3  " " ; if ($5 ~ /:/ ) printf  $5; printf " | load "; printf $(NF-2) " " $(NF-1) " " $NF}')
echo -n " |" $(free -h| awk '/Mem:/{print "mem free " $7}')
echo -n " |" $(df -h|awk '/root/{print "root fs " $5}')
echo  " |" $(df -h|awk '/home/{print "home fs " $5}')

