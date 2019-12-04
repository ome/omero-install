#!/bin/bash

set -e -u -x

. `dirname $0`/settings.env

#start
chmod go-rwx $OMERODIR/etc $OMERODIR/var

# Optionally restrict access to the OMERO data directory
# chmod go-rwx "$OMERO_DATA_DIR"

