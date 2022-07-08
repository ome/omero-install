#!/bin/bash

PGVER=${PGVER:-pg11}

if [ "$PGVER" = "pg11" ]; then
    #start-recommended
    apt-get install -y postgresql-11
    service postgresql start
    #end-recommended
elif [ "$PGVER" = "pg12" ]; then
    apt-get -y install gnupg2
    echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update
    apt-get install -y postgresql-12
    service postgresql start
elif [ "$PGVER" = "pg14" ]; then
    apt-get -y install gnupg2
    echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update
    apt-get install -y postgresql-14
    service postgresql start
fi
