#!/bin/bash

PGVER=${PGVER:-pg12}

#Postgres 12
if [ "$PGVER" = "pg12" ]; then
    #start-recommended
    apt-get update
    apt-get -y install postgresql
    service postgresql start
    #end-recommended
elif [ "$PGVER" = "pg14" ]; then
	apt-get install -y gnupg
    echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update
    apt-get -y install postgresql-14
    service postgresql start
fi

