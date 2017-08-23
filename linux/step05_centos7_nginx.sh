#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

if [ "$ICEVER" = "ice36" ]; then
#web-requirements-recommended-start
	file=~omero/OMERO.server/share/web/requirements-py27-all.txt
#web-requirements-recommended-end
else
#web-requirements-ice35-start
	file=~omero/OMERO.server/share/web/requirements-py27-all-ice35.txt
#web-requirements-ice35-end
fi

#start-install
yum -y install nginx

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