#!/bin/bash

set -e -u -x

WEBSESSION=${WEBSESSION:-true}
OMEROVER=${OMEROVER:-latest}
WEBAPPS=${WEBAPPS:-false}
PGVER=${PGVER:-pg96}
ICEVER=${ICEVER:-ice36}

source settings.env
source settings-web.env

bash -eux step01_ubuntu_init.sh

# install java
bash -eux step01_debian9_java_deps.sh

bash -eux step01_debian_deps.sh

# install ice
bash -eux step01_debian9_ice_deps.sh

if [ "$ICEVER" = "ice36" ]; then		
	cat omero-ice36.env >> /etc/profile		
fi

# install Postgres
bash -eux step01_debian9_pg_deps.sh

if $WEBSESSION ; then
    bash -eux step01_ubuntu_deps_websession.sh
fi

bash -eux step02_all_setup.sh

if [[ "$PGVER" =~ ^(pg94|pg95|pg96)$ ]]; then
	bash -eux step03_all_postgres.sh
fi
cp settings.env settings-web.env step04_omero_patch_openssl.sh step04_all_omero.sh setup_omero_db.sh ~omero

su - omero -c "OMEROVER=$OMEROVER ICEVER=$ICEVER bash -eux step04_all_omero.sh"
su - omero -c "bash -eux step04_omero_patch_openssl.sh"
su - omero -c "bash setup_omero_db.sh"

OMEROVER=$OMEROVER bash -eux step05_debian9_nginx.sh


if [ "$WEBSESSION" = true ]; then
	bash -eux step05_2_websessionconfig.sh
fi

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_ubuntu_daemon.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start
