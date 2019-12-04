#!/bin/bash

OMEROVER=${OMEROVER:-latest}

. `dirname $0`/settings-web.env

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-nginx-install
yum -y install nginx
#end-nginx-install


# Install omero-web
$VENV_WEB/bin/pip install "omero-web>=5.6.dev5"

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#start-nginx-admin
sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf

cp $OMERODIR/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

systemctl enable nginx
if [ ! "${container:-}" = docker ]; then
    systemctl start nginx
fi
#end-nginx-admin
