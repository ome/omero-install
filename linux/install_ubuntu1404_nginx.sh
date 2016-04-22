#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}
WEBAPPS=${WEBAPPS:-false}
PGVER=${PGVER:-pg94}
ICEVER=${ICEVER:-ice35}

source settings.env

bash -eux step01_ubuntu1404_init.sh

# install java
bash -eux step01_ubuntu1404_java_deps.sh

bash -eux step01_ubuntu1404_deps.sh

# install ice
bash -eux step01_ubuntu1404_ice_deps.sh

# install Postgres
bash -eux step01_ubuntu1404_pg_deps.sh

bash -eux step02_all_setup.sh

if [[ "$PGVER" =~ ^(pg94|pg95)$ ]]; then
	bash -eux step03_all_postgres.sh
fi

cp settings.env step04_all_omero.sh setup_omero_db.sh ~omero

su - omero -c "OMEROVER=$OMEROVER ICEVER=$ICEVER bash -eux step04_all_omero.sh"

su - omero -c "bash setup_omero_db.sh"

bash -eux step05_ubuntu1404_nginx.sh

if [ $WEBAPPS = true ]; then
	bash -eux step05_1_all_webapps.sh
fi

if [ "$WEBSESSION" = true ]; then
	bash -eux step05_2_websessionconfig.sh
fi

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_ubuntu1404_daemon.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start
