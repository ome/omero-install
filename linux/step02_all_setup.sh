#!/bin/bash

if [ -z "$(getent passwd omero)" ]; then
	#start-create-user
    useradd -m omero
    # Give a password to the omero user
    # e.g. passwd omero
    #end-create-user
fi

chmod a+X ~omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"