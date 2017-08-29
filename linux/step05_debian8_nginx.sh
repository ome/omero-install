#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-nginx-install
echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list
wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
rm nginx_signing.key
apt-get update
apt-get -y install nginx
#end-nginx-install

cd ~omero
if [ "$ICEVER" = "ice36" ]; then
#web-requirements-recommended-start
	pip install -r OMERO.server/share/web/requirements-py27.txt
#web-requirements-recommended-end
else
#web-requirements-ice35-start
	pip install -r OMERO.server/share/web/requirements-py27-ice35.txt
#web-requirements-ice35-end
fi

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#start-nginx-admin
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
#end-nginx-admin
