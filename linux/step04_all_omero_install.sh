#!/bin/bash
OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

set -eux

. `dirname $0`/settings.env

#start-install-omero-py
# Install omero-py
$VENV_SERVER/bin/pip install "omero-py>=5.6.dev4"
#end-install-omero-py

#start-download-omero


#start-install
if [ "$ICEVER" = "ice36" ]; then
	if [ $OMEROVER == "latest" ]; then
		#start-release-ice36
		cd /opt/omero/server
		#SERVER=https://downloads.openmicroscopy.org/latest/omero5.6/server-ice36.zip
		SERVER=https://downloads.openmicroscopy.org/omero/5.6.0-m2/artifacts/OMERO.server-5.6.0-m2-ice36-b126.zip
		wget -q $SERVER -O OMERO.server-ice36.zip
		unzip -q OMERO.server*
		#end-release-ice36
		rm OMERO.server-ice36.zip
	fi
fi

#start-link
# change ownership of the folder
chown -R omero-server OMERO.server-*
ln -s OMERO.server-*/ OMERO.server
#end-link
