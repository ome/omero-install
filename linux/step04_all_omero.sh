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
if [ "$ICEVER" = "ice36" ]; then
	#start-release-ice36
	cd ~omero
	SERVER=https://ci.openmicroscopy.org/view/OMERO-DEV/job/OMERO-DEV-merge-build/ICE=3.6,jdk=8_LATEST,label=octopus/lastSuccessfulBuild/artifact/src/target/OMERO.server-5.2.2-393-e464f65-ice36-b292.zip
	wget $SERVER
	unzip -q OMERO.server*
	#end-release-ice36
else
	# do not use omego for the release version
	if [ "$OMEROVER" = "latest"]; then
		#start-release-ice35
		cd ~omero
		SERVER=http://downloads.openmicroscopy.org/latest/omero5.2/server-ice35.zip
		wget $SERVER
		unzip -q OMERO.server*
		#end-release-ice35
	else
		/home/omero/omeroenv/bin/omego download --branch $OMEROVER server
	fi
fi
#start-link
ln -s OMERO.server-*/ OMERO.server
#end-link

#configure
OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"