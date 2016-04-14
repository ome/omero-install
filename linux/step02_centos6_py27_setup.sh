#!/bin/bash

ICEVER=${ICEVER:-ice35}

if [ -z "$(getent passwd omero)" ]; then
	#start-create-user
    useradd -m omero
    #end-create-user
fi
chmod a+X ~omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"

#start-ice
if [[ "$ICEVER" =~ "ice35" ]]; then
	#start-recommended
	echo source \~omero/omero-centos6py27.env >> ~omero/.bashrc
	#end-recommended
elif [ "$ICEVER" = "ice36" ]; then
	echo "source /opt/rh/python27/enable" >> ~omero/.bashrc
	echo "export PATH=\"/opt/rh/python27/root/usr/bin:$PATH\"" >> ~omero/.bashrc
fi
#end-ice