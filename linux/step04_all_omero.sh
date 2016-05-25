#!/bin/bash

set -e -u -x

source utils.sh

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
	/home/omero/omeroenv/bin/pip install omego==0.4.0
	#end-venv
fi

if [ $OMEROVER == "latest" ]; then
	OMEROVER=$(get_latest_version)
fi

icevalue=3.5
#start-install
if [ "$ICEVER" = "ice36" ]; then
	icevalue=3.6
	if $(is_number $OMEROVER) && $(is_latest_version $OMEROVER); then
		#start-release-ice36
		cd ~omero
		SERVER=http://downloads.openmicroscopy.org/latest/omero$OMEROVER/server-ice36.zip
		wget $SERVER -O OMERO.server-ice36.zip
		unzip -q OMERO.server*
		#end-release-ice36
	fi
else
	# do not use omego for the release version
	# Handle release version via download page.
	if $(is_number $OMEROVER) ; then
  		# one release version
  		#start-release-ice35
  		cd ~omero
  		SERVER=http://downloads.openmicroscopy.org/latest/omero$OMEROVER/server-ice35.zip
		wget $SERVER -O OMERO.server-ice35.zip
		unzip -q OMERO.server*
		#end-release-ice35
	fi
fi
# no server downloaded
if [ ! -d OMERO.server* ]; then
	# dev branches installed via omego
	/home/omero/omeroenv/bin/omego download --ice $icevalue --branch $OMEROVER server
fi

#start-link
ln -s OMERO.server-*/ OMERO.server
#end-link

#configure
OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql "" "" "$OMERO_ROOT_PASS"
#start-db

if $(is_less_than $OMEROVER 5.1); then
	OMERO.server/bin/omero db script -f OMERO.server/db.sql "" "" "$OMERO_ROOT_PASS"
else
	#start-deb-latest
	OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"
	#end-deb-latest
fi