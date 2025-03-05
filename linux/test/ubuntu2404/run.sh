#!/bin/bash

service postgresql start

#service crond start # Doesn't work in Docker
cron
service omero-server start
if [ -t 1 ] ; then
    exec bash
else
    exec tail -F /opt/omero/server/OMERO.server/var/log/*
fi
