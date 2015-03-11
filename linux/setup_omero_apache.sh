#!/bin/bash

set -e -u -x

source settings.env

OMERO.server/bin/omero web config apache --system --http "$OMERO_WEB_PORT" > OMERO.server/apache.conf.tmp
