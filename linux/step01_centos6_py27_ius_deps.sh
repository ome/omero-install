#!/bin/bash

# epel-release will be pulled as a dependency
yum -y install https://centos6.iuscommunity.org/ius-release.rpm

curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install \
	unzip \
	wget \
	tar

#wget https://centos6.iuscommunity.org/ius-release.rpm
#rpm -Uvh ius-release*.rpm

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

# Now install ice

mkdir /tmp/ice-download
cd /tmp/ice-download

wget http://downloads.openmicroscopy.org/ice/experimental/Ice-3.5.1-b1-centos6-iuspy27-x86_64.tar.gz

tar -zxvf /tmp/ice-download/Ice-3.5.1-b1-centos6-iuspy27-x86_64.tar.gz

# so we don't have to update ICE_HOME
mv Ice-3.5.1-b1-centos6-iuspy27-x86_64 /opt/Ice-3.5.1

echo /opt/Ice-3.5.1/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
