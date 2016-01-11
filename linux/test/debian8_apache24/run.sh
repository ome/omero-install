#!/bin/bash
service postgresql start
#service crond start # Doesn't work in Docker
cron
service omero start
service apache2 start
exec bash
