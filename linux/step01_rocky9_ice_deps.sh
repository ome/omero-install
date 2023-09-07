#!/bin/bash

#start-recommended
dnf config-manager --set-enabled crb
yum -y install bzip2 expat libdb-cxx

cd /tmp
wget https://github.com/sbesson/zeroc-ice-rhel9-x86_64/releases/download/20230830/Ice-3.6.5-rhel9-x86_64.tar.gz
tar xf Ice-3.6.5-rhel9-x86_64.tar.gz
mv Ice-3.6.5 /opt/ice-3.6.5
echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
#end-recommended