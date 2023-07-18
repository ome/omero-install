#!/bin/bash

dnf config-manager --set-enabled crb
yum -y install bzip2 expat openssl libdb-cxx

cd /tmp
wget https://github.com/sbesson/zeroc-ice-rockylinux9-x86_64/releases/download/202307018/Ice-3.6.5-rockylinux9-x86_64.tar.gz
tar xf Ice-3.6.5-rockylinux9-x86_64.tar.gz
mv Ice-3.6.5 ice-3.6.5
mv ice-3.6.5 /opt
echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
