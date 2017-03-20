#!/bin/bash

OMEROVER=${OMEROVER:-latest}

source utils.sh

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

p=nginx

#start-install
# require to install more recent version of nginx
# w/o the version installed is 1.4.6
add-apt-repository -y ppa:nginx/stable

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
