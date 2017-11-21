#!/usr/bin/bash
for i in `source /install_dir/admin-openrc.sh; openstack floating ip list | grep -v None | grep "160"| awk '{print $4}' | sort -n `; 
do
ping -c 2 $i | grep -q 'ttl=' && echo "$i yes"|| echo "$i no"
done
