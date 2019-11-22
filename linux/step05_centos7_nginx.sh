#!/bin/bash

OMEROVER=${OMEROVER:-latest}
VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-nginx-install
yum -y install nginx
#end-nginx-install


# set up as the omero user.
su - omero -c "VIRTUALENV=$VIRTUALENV bash -eux setup_omero_nginx.sh nginx"

#start-nginx-admin
sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf

cp OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

systemctl enable nginx
if [ ! "${container:-}" = docker ]; then
    systemctl start nginx
fi
#end-nginx-admin
