#!/bin/bash

set -e -u -x

source settings.env

set +u
source /opt/rh/python27/enable
set -u

SERVER=https://ci.openmicroscopy.org/view/DEV/job/OMERO-DEV-merge-build/156/ICE=3.5,jdk=8_LATEST,label=octopus/artifact/src/target/OMERO.server-5.2.0-74-5bd5e75-ice35-b156.zip

wget -o server-ice35.zip $SERVER
unzip -q server-ice35.zip
ln -s OMERO.server-*/ OMERO.server

OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"

psql -h localhost -U "$OMERO_DB_USER" "$OMERO_DB_NAME" < OMERO.server/db.sql

# This is the default in 5.2 so could be left unset
OMERO.server/bin/omero config set omero.web.application_server wsgi-tcp
OMERO.server/bin/omero web config nginx --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp
