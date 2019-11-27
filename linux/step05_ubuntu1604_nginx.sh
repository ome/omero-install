#!/bin/bash

OMEROVER=${OMEROVER:-latest}
. `dirname $0`/settings.env

#start-nginx-install
apt-get update
apt-get -y install nginx
#end-nginx-install

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

cd ~omero

# Install omero-web
$VIRTUALENV/bin/pip3 install "omero-web>=5.6.dev5"

# set up as the omero user.
su - omero -c "bash -x setup_omero_nginx.sh nginx"

#start-nginx-admin
cp OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start
#end-nginx-admin
