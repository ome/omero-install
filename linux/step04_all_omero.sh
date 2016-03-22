#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-omero}
PY_ENV=${PY_ENV:-py27}

source settings.env
#start-install
if [ "$PY_ENV" = "py27_scl" ]; then
	#start-py27-scl
	set +u
	source /opt/rh/python27/enable
	set -u
	#end-py27-scl
fi

if [[ ! $PY_ENV = "py27_ius" ]]; then
	#start-venv
	virtualenv /home/omero/omeroenv
	/home/omero/omeroenv/bin/pip install omego==0.3.0
	#end-venv
fi

#start-install
if [ $OMEROVER = omerodev ]; then
	/home/omero/omeroenv/bin/omego download --branch OMERO-DEV-latest server
elif [ $OMEROVER = omeromerge ]; then
	BRANCH=OMERO-DEV-merge-build
	/home/omero/omeroenv/bin/omego download --branch OMERO-DEV-merge-build server
else
	#start-release
	/home/omero/omeroenv/bin/omego download --release latest server
	#end-release
fi

#configure
ln -s OMERO.server-*/ OMERO.server

OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"