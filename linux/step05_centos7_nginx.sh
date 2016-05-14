#!/bin/bash

OMEROVER=${OMEROVER:-latest}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-install
# The following is only required to install
# latest stable version of nginx
# Default will be 1.6.3 if not set
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

#install nginx
yum -y install nginx

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

sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

systemctl enable nginx
if [ ! "${container:-}" = docker ]; then
    systemctl start nginx
fi