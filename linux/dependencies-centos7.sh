#!/bin/bash

yum -y install http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm

curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo
# TODO: Official Zeroc Ice repository for EL7
sed -i.bak 's/$releasever/6/' /etc/yum.repos.d/zeroc-ice-el6.repo

yum -y install \
	unzip \
	wget \
	java-1.7.0-openjdk \
	ice ice-python ice-servers

yum -y install \
	python-pip python-devel \
	numpy scipy python-matplotlib python-pillow Cython \
	gcc gcc-c++ \
	hdf5-devel

# Requires gcc-c++
pip install numexpr
# Requires gcc, Cython, hdf5-devel
pip install tables

# Postgres, reconfigure to allow TCP connections
yum -y install postgresql-server postgresql

service postgresql-9.3 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.3/data/pg_hba.conf
chkconfig postgresql-9.3 on
service postgresql-9.3 start
