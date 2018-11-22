#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-nginx-install
yum -y install nginx
#end-nginx-install

cd ~omero
if [ "$ICEVER" = "ice36" ]; then
#web-requirements-recommended-start
	pip install -r OMERO.server/share/web/requirements-py27.txt
#web-requirements-recommended-end
fi

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
