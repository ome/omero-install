#!/bin/bash
service postgresql-9.4 start
service crond start
service nginx start
exec bash