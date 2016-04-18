#!/bin/bash
PGVER=${1:-pg94}

if [ "$PGVER" = "pg94" ]; then
	service postgresql-9.4 start
elif [ "$PGVER" = "pg95" ]; then
	service postgresql-9.5 start
fi
service redis start
service crond start
service omero start
service nginx start
service omero-web start
exec bash
