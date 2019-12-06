#!/bin/bash

OMEROVER=${OMEROVER:-latest}

. `dirname $0`/settings-web.env

#start-nginx-install
apt-get -y install nginx gunicorn
#end-nginx-install

#start-copy
cp setup_omero_nginx.sh ~omero-server
#end-copy

# Install omero-web
$VENV_WEB/bin/pip install "omero-web>=5.6.dev5"

# set up as the omero-server user.
su - omero-server -c "bash -x setup_omero_nginx.sh nginx"

#start-nginx-admin
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.disabled
cp $OMERODIR/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
#end-nginx-admin
