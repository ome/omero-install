#!/bin/bash

OMEROVER=${OMEROVER:-latest}

source utils.sh


#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

p=nginx

#start-install
set +u
source /opt/rh/python27/enable
set -u

cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

yum -y install nginx

file=~omero/OMERO.server/share/web/requirements-py27-nginx.txt


# introduce in 5.2.0
if [ -f $file ]; then
	#start-latest
	pip install -r $file
	#end-latest
else
	#for version 5.1.x
	pip install "gunicorn>=19.3"
	p=nginx-wsgi
fi

# set up as the omero user.
if $(is_less_than $OMEROVER 5.1); then
	cp setup_omero_nginx50.sh ~omero
	su - omero -c "bash -eux setup_omero_nginx50.sh"
else
	su - omero -c "bash -eux setup_omero_nginx.sh $p"
fi

#end-install
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start