#!/bin/bash

PGVER=${PGVER:-pg94}

#Postgres 10
apt-get update
apt-get -y install postgresql
service postgresql start
