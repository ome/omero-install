#!/bin/bash

if [ -z "$(getent passwd omero)" ]; then
    #start-create-user
    useradd -mr omero-server
    # Give a password to the omero user
    # e.g. passwd omero-server
    #end-create-user
fi

chmod a+X ~omero-server

mkdir -p "$OMERO_DATA_DIR"
chown omero-server "$OMERO_DATA_DIR"
chown -R omero-server "$CONDA_ENV"
