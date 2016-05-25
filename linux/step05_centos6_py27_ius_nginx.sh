#!/bin/bash
OMEROVER=${OMEROVER:-latest}


set -e -u -x

source utils.sh
#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

p=nginx
#start-install
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

#install nginx
yum -y install nginx

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u

# Install OMERO.web requirements
file=~omero/OMERO.server/share/web/requirements-py27-nginx.txt

# introduce in 5.2.0
if [ -f $file ]; then
	#start-latest
	/home/omero/omeroenv/bin/pip2.7 install -r $file
	#end-latest
else
	#for version 5.1.x
	/home/omero/omeroenv/bin/pip2.7 install "gunicorn>=19.3"
	p=nginx-wsgi
fi
deactivate

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