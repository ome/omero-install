#!/bin/bash

yum -y install httpd24-httpd python27-mod_wsgi

# See setup_omero_apache.sh for the apache config file creation

cp ~omero/OMERO.server/apache.conf.tmp /opt/rh/httpd24/root/etc/httpd/conf.d/omero-web.conf

chkconfig httpd24-httpd on
service httpd24-httpd start
