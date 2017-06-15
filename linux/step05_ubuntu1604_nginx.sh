#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-install
apt-get update
apt-get -y install nginx

if [ "$ICEVER" = "ice36" ]; then
	file=~omero/OMERO.server/share/web/requirements-py27.txt
else
	file=~omero/OMERO.server/share/web/requirements-py27-ice35.txt
fi

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
