#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

#start-nginx-install
# required to install more recent version of nginx
# without this, the version installed is 1.4.6
add-apt-repository -y ppa:nginx/stable

apt-get update
apt-get -y install nginx
#end-nginx-install

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-requirements
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
cp OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start
#end-nginx-admin
