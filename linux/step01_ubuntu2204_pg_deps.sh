#!/bin/bash

PGVER=${PGVER:-pg15}

if [ "$PGVER" = "pg14" ]; then
  apt-get update
  apt-get -y install postgresql
  service postgresql start
elif [ "$PGVER" = "pg15" ]; then
  #start-recommended
  apt-get install -y curl ca-certificates
  install -d /usr/share/postgresql-common/pgdg
  curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
  sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

  apt-get update
  apt-get -y install postgresql-15
  service postgresql start
    #end-recommended
elif [ "$PGVER" = "pg16" ]; then
  apt-get install -y curl ca-certificates
  install -d /usr/share/postgresql-common/pgdg
  curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
  sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  apt-get update
  apt-get -y install postgresql-16
  service postgresql start
fi
