#!/bin/bash

PGVER=${PGVER:-pg12}

#Postgres 12
#start-recommended
apt-get update
apt-get -y install postgresql
service postgresql start
#end-recommended

