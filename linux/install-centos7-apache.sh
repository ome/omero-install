#!/bin/bash

set -e -u -x

OMEROVER=omero

source settings.env

bash -eux dependencies-centos7.sh

bash -eux system_setup.sh
bash -eux setup_postgres.sh

cp settings.env setup_$OMEROVER.sh ~omero
cp setup_omero_apache24.sh ~omero

if [ $OMEROVER = omerodev ]; then
	yum -y install python-virtualenv
	yum clean all
fi 
su - omero -c "bash -eux setup_$OMEROVER.sh"

su - omero -c "bash -eux setup_omero_apache24.sh"
bash -eux setup_apache_centos7.sh

#If you don't want to use the systemd scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux setup_omero_daemon_centos7.sh

#systemctl start omero.service
#systemctl start omero-web.service