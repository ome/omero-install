#!/bin/bash

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-install
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

yum -y install nginx

# Install OMERO.web requirements
pip install -r ~omero/OMERO.server/share/web/requirements-py26-nginx.txt

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh"

mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start