#!/bin/bash

echo "CREATE USER $OMERO_DB_USER PASSWORD '$OMERO_DB_PASS'" | \
    sudo -u postgres psql
sudo -u postgres createdb -O "$OMERO_DB_USER" "$OMERO_DB_NAME"

psql -P pager=off -h localhost -U "$OMERO_DB_USER" -l

