#!/bin/bash
PGVER=94
WEBSESSION=false

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -p|--pg)
    PGVER="$2"
    shift # past argument
    ;;
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

if [ "$PGVER" = "94" ]; then
	service postgresql-9.4 start
elif [ "$PGVER" = "95" ]; then
	service postgresql-9.5 start
elif [ "$PGVER" = "96" ]; then
    service postgresql-9.6 start
fi
if [ "$WEBSESSION" = "true" ]; then
	service redis start
fi
service crond start
service omero start
service nginx start

service omero-web start
exec bash
