#!/bin/bash

set -e -u -x

cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

OMEROVER=omero
#OMEROVER=omerodev

source settings.env

#install nginx
yum -y install nginx

#Create virtual env.
virtualenv /tmp/omeroenv
set +u
source /tmp/omeroenv/bin/activate
set -u

# install omero dependencies
/tmp/omeroenv/bin/pip2.7 install pillow numpy matplotlib

# Django
/tmp/omeroenv/bin/pip2.7 install "Django<1.9"

/tmp/omeroenv/bin/pip2.7 install gunicorn

echo source \~omero/omero-centos6py27ius.env >> ~omero/.bashrc
cp settings.env omero-centos6py27ius.env step04_centos6_py27_ius_${OMEROVER}.sh ~omero

if [ $OMEROVER = omerodev ]; then
	/tmp/omeroenv/bin/pip2.7 install omego
fi
su - omero -c "bash -eux step04_centos6_py27_ius_${OMEROVER}.sh"

# See setup_omero*.sh for the nginx config file creation
su - omero -c "OMERO.server/bin/omero config set omero.web.application_server wsgi-tcp"
su - omero -c "OMERO.server/bin/omero web config nginx --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp"

#remove comment
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start

bash -eux setup_centos6_selinux.sh
bash -eux step07_all_perms.sh