#!/bin/bash

#start-copy
cp setup_omero_apache24.sh ~omero
#end-copy

#start-install
apt-get -y install apache2 libapache2-mod-wsgi

# Install OMERO.web requirements
file=~omero/OMERO.server/share/web/requirements-py27-apache.txt
p=apache
# introduce in 5.2.0
if [ -f $file ]; then
	pip install -r $file
else
	#for version 5.1.x
	p=apache-wsgi
fi

#start-setup-as-omero
# See setup_omero*.sh for the apache config file creation
su - omero -c "bash -eux setup_omero_apache24.sh $p"
#end-setup-as-omero

# Modify the default value set for the ``WSGISocketPrefix`` directive in ``apache.conf.tmp``
sed -i -r -e 's|(WSGISocketPrefix run/wsgi)|#\1|' -e 's|# (WSGISocketPrefix /var/run/wsgi)|\1|' ~omero/OMERO.server/apache.conf.tmp
cp ~omero/OMERO.server/apache.conf.tmp /etc/apache2/sites-available/omero-web.conf
a2dissite 000-default.conf
a2ensite omero-web.conf

service apache2 start