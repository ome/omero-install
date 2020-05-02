#!/bin/bash

PGVER=${PGVER:-pg11}
PGVER=pg12
#Postgres 10
if [ "$PGVER" = "pg10" ]; then
    apt-get update
    apt-get -y install postgresql
    service postgresql start
elif [ "$PGVER" = "pg11" ]; then
    #start-recommended
    apt-get install -y gnupg
    echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update
    apt-get -y install postgresql-11
    service postgresql start
    #end-recommended
elif [ "$PGVER" = "pg12" ]; then
    apt-get install -y gnupg
    echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update
    apt-get -y install postgresql-12
    service postgresql start
fi
