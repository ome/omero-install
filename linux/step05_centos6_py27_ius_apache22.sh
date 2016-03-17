#!/bin/bash

#start-copy
cp setup_omero_apache22.sh ~omero
#end-copy

#start-install
#install Apache 2.2
yum -y install httpd

# install mod_wsgi compiled against 2.7
yum -y install python27-mod_wsgi

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u

# Install OMERO.web requirements
/home/omero/omeroenv/bin/pip2.7 install -r ~omero/OMERO.server/share/web/requirements-py27-apache.txt

deactivate

# See setup_omero_apache.sh for the apache config file creation
su - omero -c "bash -eux setup_omero_apache22.sh"

# Add virtual env python to the python-path parameter of the WSGIDaemonProcess directive
sed -i 's/\(python-path\=\)/\1\/home\/omero\/omeroenv\/lib64\/python2.7\/site-packages:/' ~omero/OMERO.server/apache.conf.tmp
# See setup_omero_apache.sh for the apache config file creation
cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

chkconfig httpd on
service httpd start