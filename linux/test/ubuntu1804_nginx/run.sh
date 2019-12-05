#!/bin/bash
WEBSESSION=false

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -w|--websession)
    WEBSESSION="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

service postgresql start
if [ "$WEBSESSION" = "true" ]; then
    service redis start
fi
#service crond start # Doesn't work in Docker
cron
service omero start
service nginx start
service omero-web start
if [ -t 1 ] ; then
    exec bash
else
    exec tail -F /opt/omero/server/OMERO.server/var/log/*
fi
