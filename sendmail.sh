#!/bin/bash

#set from=wdcpalert@xxx.com.cn 
#set smtp=10.199.xx.xx
#set smtp-auth-user=wdcpalert
#set smtp-auth-password=wdcpalert123
#set smtp-auth=login

to=$1
subject=$2
body=$3

cat <<EOF | mail -s "$subject" -S from=wdcpalert@xxx.com.cn -S smtp=10.199.xx.xx -S smtp-auth-password=wdcpalert123 -S smtp-auth-user=wdcpalert -S smtp-auth=login "$to"  
$body
EOF

echo "`date +"%F %T"` send to $to" >> /nmon/sendmail.log
