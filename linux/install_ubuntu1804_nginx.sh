#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}
PGVER=${PGVER:-pg10}
ICEVER=${ICEVER:-ice36}

. settings.env
. settings-web.env

bash -eux step01_ubuntu_init.sh

# install java
bash -eux step01_ubuntu1804_java_deps.sh

bash -eux step01_ubuntu1604_deps.sh

# install ice
bash -eux step01_ubuntu1804_ice_deps.sh

cat omero-ice36.env >> /etc/profile

# install Postgres
bash -eux step01_ubuntu1804_pg_deps.sh

bash -eux step02_all_setup.sh

if [[ "$PGVER" =~ ^(pg94|pg95|pg96|pg96|pg10)$ ]]; then
    bash -eux step03_all_postgres.sh
fi

cp step01_ubuntu1804_ice_venv.sh settings.env settings-web.env step05_2_websessionconfig.sh step04_omero_patch_openssl.sh step04_all_omero.sh setup_omero_db.sh ~omero

bash -eux step01_ubuntu1804_ice_venv.sh
bash -eux step04_all_omero_install.sh

su - omero -c "OMEROVER=$OMEROVER ICEVER=$ICEVER bash -eux step04_all_omero.sh"
su - omero -c "bash -eux step04_omero_patch_openssl.sh"
su - omero -c "bash setup_omero_db.sh"

OMEROVER=$OMEROVER bash -eux step05_ubuntu1804_nginx.sh


if [ "$WEBSESSION" = true ]; then
	bash -eux step05_2_websession_install.sh
    su - omero -c "bash -eux step05_2_websessionconfig.sh"
fi

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c ". /home/omero/settings.env omero admin start"
#su - omero -c ". /home/omero/settings.env omero web start"

bash -eux step06_ubuntu_daemon.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start
