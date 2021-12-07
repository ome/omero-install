#!/bin/bash

set -x

. `dirname $0`/settings.env

#configure
omero config set omero.data.dir "$OMERO_DATA_DIR"
omero config set omero.db.name "$OMERO_DB_NAME"
omero config set omero.db.user "$OMERO_DB_USER"
omero config set omero.db.pass "$OMERO_DB_PASS"
#start-db

#start-deb-latest
omero db script -f $OMERODIR/db.sql --password "$OMERO_ROOT_PASS"
#end-deb-latest

#start-seclevel
omero certificates
#end-seclevel
