#!/bin/bash

yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install \
	sudo \
	unzip \
	wget \
	java-1.7.0-openjdk \
	ice ice-python ice-servers

yum -y install \
	python-pip python-devel \
	numpy scipy matplotlib \
	gcc \
	zlib-devel \
	libjpg-devel \
	libpng-devel \
	hdf5-devel

# Requires gcc {libjpg,libpng,libtiff,zlib}-devel
pip install pillow
pip install numexpr==1.4.2
# Requires gcc, Cython, hdf5-devel
pip install tables==2.4.0

# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
yum install postgresql93-server postgresql93


# For docker testing:
#touch /etc/sysconfig/network

service postgresql-9.3 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.3/data/pg_hba.conf
service postgresql start

# Nginx
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

yum install -y nginx

