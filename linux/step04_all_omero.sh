#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}
PY_ENV=${PY_ENV:-py27}
ICEVER=${ICEVER:-ice36}

source `dirname $0`/settings.env
#start-install

if [ "$PY_ENV" = "py27" ]; then
	#start-venv
	virtualenv /home/omero/omeroenv
	/home/omero/omeroenv/bin/pip install omego==0.6.0
	#end-venv
fi


icevalue=3.6
#start-install
if [ "$ICEVER" = "ice36" ]; then
	if [ $OMEROVER == "latest" ]; then
		#start-release-ice36
		cd ~omero
		SERVER=https://downloads.openmicroscopy.org/latest/omero5/server-ice36.zip
		wget -q $SERVER -O OMERO.server-ice36.zip
		unzip -q OMERO.server*
		#end-release-ice36
	fi
fi
# no server downloaded
if [ ! -d OMERO.server* ]; then
	# dev branches installed via omego
	/home/omero/omeroenv/bin/omego download -q --ice $icevalue --branch $OMEROVER server
fi

#start-link
ln -s OMERO.server-*/ OMERO.server
#end-link

#configure
OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
#start-db

#start-deb-latest
OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"
#end-deb-latest