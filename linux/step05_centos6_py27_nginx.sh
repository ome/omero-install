#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

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

if [ "$ICEVER" = "ice36" ]; then
	file=~omero/OMERO.server/share/web/requirements-py27-all.txt
else
	file=~omero/OMERO.server/share/web/requirements-py27-all-ice35.txt
fi

#start-latest
pip install -r $file
#end-latest

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#end-install
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start