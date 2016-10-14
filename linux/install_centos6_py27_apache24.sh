#!/bin/bash

set -e -u -x

WEBSESSION=${WEBSESSION:-false}
OMEROVER=${OMEROVER:-latest}
WEBAPPS=${WEBAPPS:-false}
PGVER=${PGVER:-pg94}
ICEVER=${ICEVER:-ice36}

source settings.env

bash -eux step01_centos6_py27_init.sh

# install java
bash -eux step01_centos_java_deps.sh

bash -eux step01_centos6_py27_deps.sh

# install ice
bash -eux step01_centos6_py27_ice_deps.sh

if $WEBSESSION ; then
    bash -eux step01_centos6_py27_deps_websession.sh
fi

# install Postgres
bash -eux step01_centos6_pg_deps.sh

ICEVER=$ICEVER bash -eux step02_centos6_py27_setup.sh

if [[ "$PGVER" =~ ^(pg94|pg95)$ ]]; then
	bash -eux step03_all_postgres.sh
fi

cp utils.sh settings.env omero-centos6py27.env step04_all_omero.sh setup_omero_db.sh ~omero

su - omero -c "OMEROVER=$OMEROVER PY_ENV=py27_scl ICEVER=$ICEVER bash -eux step04_all_omero.sh"

su - omero -c "bash setup_omero_db.sh"


if [ $WEBAPPS = true ]; then
	OMEROVER=$OMEROVER PY_ENV=py27_scl bash -eux step05_1_all_webapps.sh
fi

if [ "$WEBSESSION" = true ]; then
	OMEROVER=$OMEROVER PY_ENV=py27_scl bash -eux step05_2_websessionconfig.sh
fi

bash -eux step05_centos6_py27_apache24.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux setup_centos_selinux.sh

bash -eux step06_centos6_daemon_no_web.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start
