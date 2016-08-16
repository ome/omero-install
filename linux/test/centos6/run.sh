#!/bin/bash
PGVER=94

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -p|--pg)
    PGVER="$2"
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
fi
service crond start
service omero start
service httpd start
exec bash
