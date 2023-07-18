#!/bin/bash
OMEROVER=${OMEROVER:-latest}

set -eux

. `dirname $0`/settings.env


#start-install
if [ $OMEROVER == "latest" ]; then
	#start-release-ice36
	cd /opt/omero/server
	SERVER=https://downloads.openmicroscopy.org/omero/5.6/server-ice36.zip
	wget -q $SERVER -O OMERO.server-ice36.zip
	unzip -q OMERO.server*
	#end-release-ice36
	rm OMERO.server-ice36.zip
fi

#start-link
# change ownership of the folder
chown -R omero-server OMERO.server-*
ln -s OMERO.server-*/ OMERO.server
#end-link
