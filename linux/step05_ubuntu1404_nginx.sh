#!/bin/bash

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-install
# require to install more recent version of nginx
# w/o the version installed is 1.4.6
add-apt-repository -y ppa:nginx/stable

apt-get update
apt-get -y install nginx

file=~omero/OMERO.server/share/web/requirements-py27-nginx.txt
p=nginx

# introduce in 5.2.0
if [ -f $file ]; then
	pip install -r $file
else
	#for version 5.1.x
	pip install "gunicorn>=19.3"
	p=nginx-wsgi
fi

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh $p"

cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start