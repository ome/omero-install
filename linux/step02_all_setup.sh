#!/bin/bash


if [ -z "$(getent passwd omero)" ]; then
    useradd -m omero
fi

chmod a+X ~omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"