#!/bin/bash
NGINXCMD=${1:-nginx}
VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}
set -e -u -x

. `dirname $0`/settings-web.env

export OMERODIR=/home/omero/OMERO.server
. $VIRTUALENV/bin/activate

#start-config
omero config set omero.web.application_server wsgi-tcp
omero web config $NGINXCMD --http "$WEBPORT" > /home/omero/OMERO.server/nginx.conf.tmp
