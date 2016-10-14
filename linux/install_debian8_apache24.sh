#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}
WEBAPPS=${WEBAPPS:-false}
PGVER=${PGVER:-pg94}
ICEVER=${ICEVER:-ice36}

source settings.env

bash -eux step01_ubuntu1404_init.sh

# install java
bash -eux step01_debian8_java_deps.sh

bash -eux step01_debian8_deps.sh

# install ice
bash -eux step01_debian8_ice_deps.sh

if [ "$ICEVER" = "ice36" ]; then		
	cat omero-ice36.env >> /etc/profile		
fi

# install Postgres
bash -eux step01_debian8_pg_deps.sh

bash -eux step02_all_setup.sh

if [[ "$PGVER" =~ ^(pg94|pg95)$ ]]; then
	bash -eux step03_all_postgres.sh
fi

cp utils.sh settings.env step04_all_omero.sh setup_omero_db.sh ~omero
su - omero -c "OMEROVER=$OMEROVER ICEVER=$ICEVER bash -eux step04_all_omero.sh"

su - omero -c "bash setup_omero_db.sh"

if [ $WEBAPPS = true ]; then
	OMEROVER=$OMEROVER bash -eux step05_1_all_webapps.sh
fi

if [ "$WEBSESSION" = true ]; then
	bash -eux step05_2_websessionconfig.sh
fi

bash -eux step05_ubuntu1404_apache24.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_ubuntu1404_daemon_no_web.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start
