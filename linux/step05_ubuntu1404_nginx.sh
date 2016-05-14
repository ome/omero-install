#!/bin/bash

OMEROVER=${OMEROVER:-latest}

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
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start