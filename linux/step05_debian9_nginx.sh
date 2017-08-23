#!/bin/bash

OMEROVER=${OMEROVER:-latest}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#web-requirements-recommended-start
	file=~omero/OMERO.server/share/web/requirements-py27-all.txt
#web-requirements-recommended-end

#start-install
apt-get -y install nginx

#start-latest
pip install -r $file
#end-latest

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#end-install
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start