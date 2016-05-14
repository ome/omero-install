#!/bin/bash

OMEROVER=${OMEROVER:-latest}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-install
echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list
wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
rm nginx_signing.key
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

b=true
if [[ "$OMEROVER" == *latest ]]; then
	#determine the version to download
	splitValue=(${OMEROVER//-/ })
    length=${#splitValue[@]};
    if [ $length -gt 1 ]; then
        version=${splitValue[$((length-2))]}
        if (( $(echo "$version < 5.1" |bc -l) )); then
        	b=false
        fi
    fi
fi

# set up as the omero user.
if [ "$b" = true ]; then
	su - omero -c "bash -eux setup_omero_nginx.sh $p"
else
	cp setup_omero_nginx50.sh ~omero
	su - omero -c "bash -eux setup_omero_nginx50.sh"
fi

mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start