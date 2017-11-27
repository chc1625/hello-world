#! /bin/sh  
used=`free -m | awk 'NR==2' | awk '{print $3}'`  
free=`free -m | awk 'NR==2' | awk '{print $4}'`  
echo "===========================" >> /nmon/memory/logs/mem.log  
date >> /nmon/memory/logs/mem.log  
echo "Memory usage before | [Use：${used}MB][Free：${free}MB]" >> /nmon/memory/logs/mem.log  
if [ $free -le 4000 ] ; then  
                sync && echo 1 > /proc/sys/vm/drop_caches  
                sync && echo 2 > /proc/sys/vm/drop_caches  
                sync && echo 3 > /proc/sys/vm/drop_caches  
                used_ok=`free -m | awk 'NR==2' | awk '{print $3}'`  
                free_ok=`free -m | awk 'NR==2' | awk '{print $4}'`  
                echo "Memory usage after | [Use：${used_ok}MB][Free：${free_ok}MB]" >> /nmon/memory/logs/mem.log  
                echo "OK" >> /nmon/memory/logs/mem.log  
else  
                echo "Not required" >> /nmon/memory/logs/mem.log  
fi  
