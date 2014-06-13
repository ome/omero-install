#!/bin/bash

yum -y install httpd

yum -y install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
yum -y install mod_fastcgi
# Note you may want to disable the rpmforge repo after installing
# mod_fastcgi by setting `enabled = 0` in /etc/yum.repos.d/rpmforge.repo

# Disable the default FastCgi options
sed -i.omero 's/^\s*FastCgi/#&/' /etc/httpd/conf.d/fastcgi.conf

# See setup_omero_apache.sh for the apache config file creation

cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

chkconfig httpd on
service httpd start
