#!/bin/bash
service postgresql-9.4 start
service crond start
service omero start
service httpd24-httpd start
exec bash
