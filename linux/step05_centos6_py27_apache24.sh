#!/bin/bash

#start-copy
cp setup_omero_apache24.sh ~omero
#end-copy

#start-install
set +u
source /opt/rh/python27/enable
set -u

yum -y install httpd24-httpd python27-mod_wsgi

# Install OMERO.web requirements
pip install -r ~omero/OMERO.server/share/web/requirements-py27-apache.txt

# See setup_omero_apache.sh for the apache config file creation
su - omero -c "bash -eux setup_omero_apache24.sh"

cp ~omero/OMERO.server/apache.conf.tmp /opt/rh/httpd24/root/etc/httpd/conf.d/omero-web.conf

chkconfig httpd24-httpd on
service httpd24-httpd start