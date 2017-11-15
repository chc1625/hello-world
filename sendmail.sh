#!/bin/bash

#set from=alert@xxx.com.cn 
#set smtp=10.199.xx.xx
#set smtp-auth-user=alert
#set smtp-auth-password=alert123
#set smtp-auth=login

to=$1
subject=$2
body=$3

cat <<EOF | mail -s "$subject" -S from=alert@xxx.com.cn -S smtp=10.199.xx.xx -S smtp-auth-password=alert123 -S smtp-auth-user=alert -S smtp-auth=login "$to"  
$body
EOF

echo "`date +"%F %T"` send to $to" >> /nmon/sendmail.log
