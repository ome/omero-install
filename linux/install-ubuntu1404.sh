#!/bin/bash

set -e -u -x

OMEROVER=omero
#OMEROVER=omerodev

source settings.env

bash -eux dependencies-ubuntu1404.sh

bash -eux system_setup.sh
bash -eux setup_postgres.sh

cp settings.env setup_$OMEROVER.sh ~omero

su - omero -c "bash -eux setup_$OMEROVER.sh"

bash -eux setup_nginx_ubuntu1404.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux setup_omero_daemon_ubuntu1404.sh

bash -eux setup_permissions.sh

bash -eux setup_cron.sh

#service omero start
#service omero-web start
