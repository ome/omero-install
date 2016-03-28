#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}
PY_ENV=${PY_ENV:-py27}
ICEVER=${ICEVER:-ice35}

source `dirname $0`/settings.env
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
if [ $ICEVER="ice36" ]; then
	#tmp build from branch
	cd ~omero
	git clone --depth=1 https://github.com/jburel/openmicroscopy.git

	cd openmicroscopy
	git submodule init
	git submodule update
	cd ..

	#unzip -q ice36.zip
	sed -i 's/omero.version=UNKNOWN/omero.version=5.2.2/g' openmicroscopy/etc/build.properties
	openmicroscopy/build.py

	mv openmicroscopy/dist OMERO.server
else
	#start-release
	/home/omero/omeroenv/bin/omego download --branch $OMEROVER server
	#end-release
	ln -s OMERO.server-*/ OMERO.server
fi

#configure
OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"