#!/bin/bash

su - postgres -c "/usr/bin/pg_ctl start -D /var/lib/pgsql/data -w"

#service crond start # Doesn't work in Docker
su - omero-server -c ". /home/omero-server/settings.env && omero admin start"
if [ -t 1 ] ; then
    exec bash
else
    exec tail -F /opt/omero/server/OMERO.server/var/log/*
fi
