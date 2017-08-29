#!/bin/bash

set -e -u -x

source `dirname $0`/settings.env

cd ~omero
#start
chmod go-rwx OMERO.server/etc OMERO.server/var

# Optionally restrict access to the OMERO data directory
# chmod go-rwx "$OMERO_DATA_DIR"

