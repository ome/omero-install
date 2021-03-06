#!/bin/bash
OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

set -eux

. `dirname $0`/settings.env

#start-install-omero-py
# Install omero-py
$VENV_SERVER/bin/pip install "omero-py>=5.8.0"
#end-install-omero-py

#start-download-omero


#start-install
if [ "$ICEVER" = "ice36" ]; then
	if [ $OMEROVER == "latest" ]; then
		#start-release-ice36
		cd /opt/omero/server
		SERVER=https://github.com/ome/openmicroscopy/releases/download/v5.6.3/OMERO.server-5.6.3-ice36-b228.zip
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
