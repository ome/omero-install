#!/bin/bash
service postgresql-9.4 start
service crond start
service omero start
service nginx start
service omero-web start
exec bash
