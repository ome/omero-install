#!/bin/bash

cp setup_omero_apache24.sh ~omero
su - omero -c "bash -eux setup_omero_apache24.sh"

yum -y install httpd24u

# cannot use python27-mod_wsgi from ius since httpd2.2 is a dependency
# install via pip.
pip install mod_wsgi-httpd
pip install mod_wsgi

# See setup_omero_apache.sh for the apache config file creation

cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

# create wsgi.conf file
cat << EOF > /etc/httpd/conf.d/wsgi.conf
LoadModule wsgi_module /usr/lib64/python2.7/site-packages/mod_wsgi/server/mod_wsgi-py27.so
EOF

chkconfig httpd on
service httpd start

bash -eux setup_centos6_selinux.sh