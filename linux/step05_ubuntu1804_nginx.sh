#!/bin/bash

OMEROVER=${OMEROVER:-latest}

. `dirname $0`/settings-web.env

#start-nginx-install
apt-get update
apt-get -y install nginx
#end-nginx-install

#start-copy
cp setup_omero_nginx.sh ~omero-server
#end-copy


# Install omero-web
$VENV_WEB/bin/pip install "omero-web>=5.6.dev5"

# set up as the omero-server user.
su - omero-server -c "bash -eux setup_omero_nginx.sh nginx"

#start-nginx-admin
cp $OMERODIR/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start
#end-nginx-admin
