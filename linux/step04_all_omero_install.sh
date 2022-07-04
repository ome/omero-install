#!/bin/bash
OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

set -eux

. `dirname $0`/settings.env


#start-install
if [ "$ICEVER" = "ice36" ] || [ "$ICEVER" = "ice36-devel" ]; then
	if [ $OMEROVER == "latest" ]; then
		#start-release-ice36
		cd /opt/omero/server
		omego download --release 5 server
		#end-release-ice36
		rm OMERO.server-*.zip
	fi
fi

#start-link
# change ownership of the folder
chown -R omero-server OMERO.server-*
ln -s OMERO.server-*/ OMERO.server
#end-link
