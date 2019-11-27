#!/bin/bash

OMEROVER=${OMEROVER:-latest}

. `dirname $0`/settings.env

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-nginx-install
yum -y install nginx
#end-nginx-install

cd ~omero

# Install omero-web
$VIRTUALENV/bin/pip3 install "omero-web>=5.6.dev5"

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#start-nginx-admin
sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf

cp OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

systemctl enable nginx
if [ ! "${container:-}" = docker ]; then
    systemctl start nginx
fi
#end-nginx-admin
