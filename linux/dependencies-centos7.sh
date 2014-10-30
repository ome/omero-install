#!/bin/bash

yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm

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

# Note systemd doesn't work stright off on docker
DOCKER=1
if [ $DOCKER -eq 1 ]; then
	#export PGDATA=/var/lib/pgsql/data
	su postgres -c 'initdb /var/lib/pgsql/data'
	sed -i.bak -re 's/^(host.*)trust/\1md5/' /var/lib/pgsql/data/pg_hba.conf
	su postgres -c 'pg_ctl -D /var/lib/pgsql/data -l /var/lib/pgsql/logfile start'
else
	TODO: service postgresql-9.3 initdb
	sed -i.bak -re 's/^(host.*)trust/\1md5/' /var/lib/pgsql/data/pg_hba.conf
	TODO: chkconfig postgresql-9.3 on
	systemctl start postgresql
fi
