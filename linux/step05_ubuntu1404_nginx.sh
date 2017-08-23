#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-requirements
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
# required to install more recent version of nginx
# without this, the version installed is 1.4.6
add-apt-repository -y ppa:nginx/stable

apt-get update
apt-get -y install nginx


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
