#!/bin/bash

PGVER=${PGVER:-pg96}

if [ "$PGVER" = "pg94" ]; then
    # Postgres installation: version installed will be 9.6
    #start-recommended
    apt-get -y install postgresql
    #end-recommended
    service postgresql start
elif [ "$PGVER" = "pg10" ]; then
	apt-get install -y gnupg
	echo "deb [arch=amd64] http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update
    apt-get install -y postgresql-10
	service postgresql start
fi