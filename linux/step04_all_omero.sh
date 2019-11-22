#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}
VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}

. `dirname $0`/settings.env
#start-install

icevalue=3.6
. $VIRTUALENV/bin/activate
#start-install

if [ "$ICEVER" = "ice36" ]; then
	if [ $OMEROVER == "latest" ]; then
		#start-release-ice36
		cd ~omero
		#SERVER=https://downloads.openmicroscopy.org/latest/omero5.6/server-ice36.zip
		SERVER=https://downloads.openmicroscopy.org/omero/5.6.0-m2/artifacts/OMERO.server-5.6.0-m2-ice36-b126.zip
		wget -q $SERVER -O OMERO.server-ice36.zip
		unzip -q OMERO.server*
		#end-release-ice36
		rm OMERO.server-ice36.zip
	fi
fi
# no server downloaded
if [ ! -d OMERO.server* ]; then
	# dev branches installed via omego
	#start-venv
	$VIRTUALENV/bin/pip3 install omego==0.6.0
	#end-venv
	$VIRTUALENV/bin/omego download -q --ice $icevalue --branch $OMEROVER server
fi

#start-link
ln -s OMERO.server-*/ OMERO.server
# set OMERODIR
export OMERODIR=OMERO.server
#end-link

#configure


# Install omero-py
pip3 install "omero-py>=5.6.dev4"
# Install omero-web
pip3 install "omero-web>=5.6.dev5"

omero config set omero.data.dir "$OMERO_DATA_DIR"
omero config set omero.db.name "$OMERO_DB_NAME"
omero config set omero.db.user "$OMERO_DB_USER"
omero config set omero.db.pass "$OMERO_DB_PASS"
#start-db

#start-deb-latest
omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"
#end-deb-latest
