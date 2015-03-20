#!/bin/bash
service postgresql start
#service crond start # Doesn't work in Docker
cron
service omero start
service nginx start
service omero-web start
bash
