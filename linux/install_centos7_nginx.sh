#!/bin/bash

set -e -u -x

WEBSESSION=${WEBSESSION:-false}
OMEROVER=${OMEROVER:-latest}
PGVER=${PGVER:-pg10}
ICEVER=${ICEVER:-ice36}
VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}

source `dirname $0`/settings.env
source `dirname $0`/settings-web.env

bash -eux step01_centos7_init.sh

# install java
bash -eux step01_centos_java_deps.sh

bash -eux step01_centos7_deps.sh

# install ice
bash -eux step01_centos7_ice_deps.sh

if $WEBSESSION ; then
    bash -eux step01_centos7_deps_websession.sh
fi

# install Postgres
bash -eux step01_centos7_pg_deps.sh

bash -eux step02_all_setup.sh

if [[ "$PGVER" =~ ^(pg94|pg95|pg96|pg10)$ ]]; then
	bash -eux step03_all_postgres.sh
fi

cp step01_centos7_ice_venv.sh settings.env settings-web.env step04_all_omero.sh setup_omero_db.sh ~omero

# Create a virtual env to install Ice Python binding as the omero user
su - omero -c "VIRTUALENV=$VIRTUALENV bash -eux step01_centos7_ice_venv.sh"

su - omero -c "OMEROVER=$OMEROVER ICEVER=$ICEVER VIRTUALENV=$VIRTUALENV bash -eux step04_all_omero.sh"

su - omero -c "bash setup_omero_db.sh"

OMEROVER=$OMEROVER ICEVER=$ICEVER VIRTUALENV=$VIRTUALENV bash -eux step05_centos7_nginx.sh

if [ "$WEBSESSION" = true ]; then
	su - omero -c "VIRTUALENV=$VIRTUALENV bash -eux step05_2_websessionconfig.sh"
fi

#If you don't want to use the systemd scripts you can start OMERO manually:
#su - omero -c "source $VIRTUALENV/bin/activate;OMERODIR=OMERO.server omero admin start"
#su - omero -c "source $VIRTUALENV/bin/activate;OMERODIR=${OMERO_SERVER} omero web start"

bash -eux setup_centos_selinux.sh

PGVER=$PGVER bash -eux step06_centos7_daemon.sh

#systemctl start omero.service
#systemctl start omero-web.service
