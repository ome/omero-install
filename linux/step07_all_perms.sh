#!/bin/bash

set -e -u -x

source `dirname $0`/settings.env

#start
chmod go-rwx ~omero/OMERO.server/etc ~omero/OMERO.server/var

# Optionally restrict access to the OMERO data directory
#chmod go-rwx "$OMERO_DATA_DIR"

