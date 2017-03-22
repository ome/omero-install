#!/bin/bash

OMEROVER=${OMEROVER:-latest}


#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy


#start-install

#install nginx
yum -y install nginx

file=~omero/OMERO.server/share/web/requirements-py27.txt

#start-latest
pip install -r $file
#end-latest

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#end-install
sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf

cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

systemctl enable nginx
if [ ! "${container:-}" = docker ]; then
    systemctl start nginx
fi