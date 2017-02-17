#!/bin/bash

OMEROVER=${OMEROVER:-latest}

source utils.sh

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

p=nginx

#start-install
apt-get update
apt-get -y install nginx

file=~omero/OMERO.server/share/web/requirements-py27-nginx.txt

# introduced in 5.2.0
if [ -f $file ]; then
	#start-latest
	pip install -r $file
	#end-latest
else
	#for version 5.1.x
	pip install "gunicorn>=19.3"
	p=nginx-wsgi
fi

# set up as the omero user.
if $(is_less_than $OMEROVER 5.1); then
	cp setup_omero_nginx50.sh ~omero
	su - omero -c "bash -eux setup_omero_nginx50.sh"
else
	su - omero -c "bash -eux setup_omero_nginx.sh $p"
fi

#end-install
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start