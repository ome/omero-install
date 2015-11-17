#!/bin/bash

set -e -u -x

OMEROVER=omero
#OMEROVER=omerodev

source settings.env

bash -eux dependencies-centos6py27.sh
bash -eux dependencies-ice-centos6py27.sh

bash -eux system_setup.sh
bash -eux user_setup_centos6py27.sh
bash -eux setup_postgres.sh

cp settings.env omero-centos6py27.env setup_${OMEROVER}_centos6py27.sh ~omero

su - omero -c "bash -eux setup_${OMEROVER}_centos6py27.sh"

bash -eux setup_nginx_centos6py27.sh

bash -eux setup_centos6_selinux.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux setup_omero_daemon_centos6.sh

bash -eux setup_permissions.sh

bash -eux setup_cron.sh

#service omero start
#service omero-web start
