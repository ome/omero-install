#!/bin/bash

yum -y install epel-release

curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install \
	unzip \
	wget

wget https://centos6.iuscommunity.org/ius-release.rpm
rpm -Uvh ius-release*.rpm

yum -y install \
	java-1.8.0-openjdk \
	db53 db53-devel db53-utils mcpp-devel

yum -y install \
	python27 \
	python27-devel \
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

# TODO: review
# First get the setup script for Setuptools:
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
 
# Then install it for Python 2.7:
python2.7 ez_setup.py
easy_install pip
export PYTHONWARNINGS="ignore:Unverified HTTPS request"
pip install virtualenv

# dependencies
pip install tables pillow numpy matplotlib

# Django
pip install "Django<1.9"

# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
yum -y install postgresql94-server postgresql94

service postgresql-9.4 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
chkconfig postgresql-9.4 on
service postgresql-9.4 start

# Now get and build ice
yum -y install tar

mkdir /tmp/ice
cd /tmp/ice

curl -Lo Ice-3.5.1.tar.gz https://zeroc.com/download/Ice/3.5/Ice-3.5.1.tar.gz

tar xvf Ice-3.5.1.tar.gz
cd Ice-3.5.1

cd cpp

make && make test && make install
cd ../py

virtualenv omero --system-site-packages
set +u
source omero/bin/activate
set -u

make && make test && make install
deactivate

echo /opt/Ice-3.5.1/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
