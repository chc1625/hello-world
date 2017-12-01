localpath="/var/www/html/centos"
mirror="rsync.mirrors.ustc.edu.cn::centos"
rsync="rsync -avzH --delete"
verlist="7"
#baselist="centosplus extras fasttrack os updates"
baselist="centosplus extras fasttrack os updates storage virt"
archlist="x86_64"
for ver in $verlist
do
        for base in $baselist
        do
                for arch in $archlist
                do
                        remote=$mirror/$ver/$base/$arch/
                        mkdir -pv $localpath/$ver/$base/$arch/
                        $rsync $remote $localpath/$ver/$base/$arch/
                done
        done
done 


#!/usr/bin/bash

localpath="/var/www/html/ceph-rpm"
mirror="rsync.mirrors.ustc.edu.cn::ceph"
rsync="rsync -avzH --delete"
verlist="rpm-luminous"
#baselist="centosplus extras fasttrack os updates"
baselist="el7"
archlist="x86_64"
for ver in $verlist
do
        for base in $baselist
        do
                for arch in $archlist
                do
                        remote=$mirror/$ver/$base/$arch/
                        mkdir -pv $localpath/$ver/$base/$arch/
                        $rsync $remote $localpath/$ver/$base/$arch/
                done
        done
done 
