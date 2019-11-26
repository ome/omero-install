#!/bin/bash
NGINXCMD=${1:-nginx}
VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}
set -x

. `dirname $0`/settings-web.env
. `dirname $0`/settings.env

#start-config
omero config set omero.web.application_server wsgi-tcp
omero web config $NGINXCMD --http "$WEBPORT" > /home/omero/OMERO.server/nginx.conf.tmp
