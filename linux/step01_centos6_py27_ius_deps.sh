#!/bin/bash

yum -y install epel-release

curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install \
	unzip \
	wget \
	tar

wget https://centos6.iuscommunity.org/ius-release.rpm
rpm -Uvh ius-release*.rpm

yum -y install \
	java-1.8.0-openjdk \
	db53 db53-devel db53-utils mcpp-devel

yum -y install \
	python27 \
	python27-devel \
	python27-pip \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	zlib-devel \
	hdf5-devel \
	freetype-devel \
	expat-devel \
	bzip2-devel \
	openssl-devel


# TODO: this installs a lot of unecessary packages:
yum -y groupinstall "Development Tools"

export PYTHONWARNINGS="ignore:Unverified HTTPS request"
pip2.7 install virtualenv


# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
yum -y install postgresql94-server postgresql94

service postgresql-9.4 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
chkconfig postgresql-9.4 on
service postgresql-9.4 start

# start virtualenv
virtualenv /tmp/omero-ice
set +u
source /tmp/omero-ice/bin/activate
set -u
# Now get and build ice

mkdir /tmp/ice
cd /tmp/ice

curl -Lo Ice-3.5.1.tar.gz https://zeroc.com/download/Ice/3.5/Ice-3.5.1.tar.gz

tar xvf Ice-3.5.1.tar.gz
cd Ice-3.5.1

cd cpp

#make && make test && make install
make && make install
cd ../py

#make && make test && make install
make && make install

echo /opt/Ice-3.5.1/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
deactivate
