#!/bin/bash
OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}


set -e -u -x

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

#start-nginx-install
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF
yum -y install nginx
#end-nginx-install

cd ~omero


#start-web-dependencies
virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u

if [ "$ICEVER" = "ice36" ]; then
#web-requirements-recommended-start
	/home/omero/omeroenv/bin/pip2.7 install -r OMERO.server/share/web/requirements-py27.txt
#web-requirements-recommended-end
else
#web-requirements-ice35-start
	/home/omero/omeroenv/bin/pip2.7 install -r OMERO.server/share/web/requirements-py27-ice35.txt
#web-requirements-ice35-end
fi
deactivate
#end-web-dependencies

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#start-nginx-admin
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
#end-nginx-admin
