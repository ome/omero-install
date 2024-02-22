#!/bin/bash

PGVER=${PGVER:-pg15}

if [ "$PGVER" = "pg14" ]; then
  #start-recommended
  apt-get update
  apt-get -y install postgresql
  service postgresql start
  #end-recommended
elif [ "$PGVER" = "pg15" ]; then
  apt-get install -y gnupg
  echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
  apt-get update
  apt-get -y install postgresql-15
  service postgresql start
elif [ "$PGVER" = "pg16" ]; then
  apt-get install -y gnupg
  echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
  apt-get update
  apt-get -y install postgresql-16
  service postgresql start
fi
