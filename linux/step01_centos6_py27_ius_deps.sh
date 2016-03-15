#!/bin/bash

yum -y install \
	python27 \
	python27-devel \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	hdf5-devel \
	zlib-devel \
	freetype-devel

# install pip and virtualenv using Python 2.6 
yum -y install python-pip

pip install --upgrade virtualenv

#if virtualenv is not installed (unlikely)
#yum -y install python27-pip
#pip2.7 install virtualenv

# TODO: this installs a lot of unecessary packages:
yum -y groupinstall "Development Tools"

export PYTHONWARNINGS="ignore:Unverified HTTPS request"


# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
yum -y install postgresql94-server postgresql94

service postgresql-9.4 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
chkconfig postgresql-9.4 on
service postgresql-9.4 start
