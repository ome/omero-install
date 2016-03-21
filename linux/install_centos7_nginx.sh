#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-omero}
WEBAPPS=${WEBAPPS:-false}
PGVER=${PGVER:-pg94}

source `dirname $0`/settings.env

bash -eux step01_centos7_init.sh

# install java
bash -eux step01_centos_java_deps.sh

# install ice
bash -eux step01_centos7_ice_deps.sh

bash -eux step01_centos7_deps.sh

# install Postgres
bash -eux step01_centos7_pg_deps.sh

bash -eux step02_all_setup.sh

if [[ "$PGVER" =~ ^(pg94|pg95)$ ]]; then
	bash -eux step03_all_postgres.sh
fi

cp settings.env step04_all_omero.sh ~omero
su - omero -c "OMEROVER=$OMEROVER bash -eux step04_all_omero.sh"

bash -eux step05_centos7_nginx.sh

if [ $WEBAPPS = true ]; then
	bash -eux step05_1_all_webapps.sh
fi

#If you don't want to use the systemd scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux setup_centos_selinux.sh

bash -eux step06_centos7_daemon.sh

#systemctl start omero.service
#systemctl start omero-web.service
