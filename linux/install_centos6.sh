#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}
PGVER=${PGVER:-pg94}
ICEVER=${ICEVER:-ice36}

source settings.env

bash -eux step01_centos6_init.sh

# install java
bash -eux step01_centos_java_deps.sh

bash -eux step01_centos6_deps.sh

# install ice
bash -eux step01_centos6_ice_deps.sh

# install Postgres
bash -eux step01_centos6_pg_deps.sh

bash -eux step02_all_setup.sh

if [[ "$PGVER" =~ ^(pg94|pg95|pg96)$ ]]; then
	bash -eux step03_all_postgres.sh
fi

cp settings.env step04_all_omero.sh setup_omero_db.sh ~omero
su - omero -c "OMEROVER=$OMEROVER ICEVER=$ICEVER bash -eux step04_all_omero.sh"

su - omero -c "bash setup_omero_db.sh"

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"

bash -eux setup_centos_selinux.sh

bash -eux step06_centos6_daemon_no_web.sh

bash -eux step07_all_perms.sh

#service omero start
