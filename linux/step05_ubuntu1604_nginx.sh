#!/bin/bash

OMEROVER=${OMEROVER:-latest}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-install
apt-get update
apt-get -y install nginx

file=~omero/OMERO.server/share/web/requirements-py27-all.txt

#start-latest
pip install -r $file
#end-latest

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#end-install
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start
