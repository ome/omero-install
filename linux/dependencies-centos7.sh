#!/bin/bash

yum -y install epel-release

curl -o /etc/yum.repos.d/zeroc-ice-el7.repo \
	http://download.zeroc.com/Ice/3.5/el7/zeroc-ice-el7.repo

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
PGSETUP_INITDB_OPTIONS=--encoding=UTF8 postgresql-setup initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/data/pg_hba.conf

# Note postgres and systemd need some fiddling to work inside docker
if [ "$container" = "docker" ]; then
	sed -i.bak -re 's/^(OOMScoreAdjust.*)/#\1/' /usr/lib/systemd/system/postgresql.service
fi
systemctl start postgresql
systemctl enable postgresql
