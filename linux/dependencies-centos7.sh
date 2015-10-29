#!/bin/bash

yum -y install epel-release

curl -o /etc/yum.repos.d/zeroc-ice-el7.repo \
	http://download.zeroc.com/Ice/3.5/el7/zeroc-ice-el7.repo

yum -y install \
	unzip \
	wget \
	java-1.8.0-openjdk \
	ice ice-python ice-servers

yum -y install \
	python-pip python-devel \
	numpy scipy python-matplotlib python-pillow python-tables

# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm
yum -y install postgresql94-server postgresql94
PGSETUP_INITDB_OPTIONS=--encoding=UTF8 postgresql-setup initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/data/pg_hba.conf

# Note postgres and systemd need some fiddling to work inside docker
if [ "$container" = "docker" ]; then
	sed -i.bak -re 's/^(OOMScoreAdjust.*)/#\1/' /usr/lib/systemd/system/postgresql.service
fi
systemctl start postgresql
systemctl enable postgresql
