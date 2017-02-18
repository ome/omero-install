#!/bin/bash

PGVER=${PGVER:-pg94}


# Postgres installation
if [ "$PGVER" = "pg94" ]; then
	apt-get update
	apt-get -y install postgresql
	service postgresql start
elif [ "$PGVER" = "pg95" ]; then
	apt-get -y install apt-transport-https
	add-apt-repository -y "deb https://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main 9.5"
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
	apt-get update
	apt-get -y install postgresql-9.5
	service postgresql start
elif [ "$PGVER" = "pg96" ]; then
	#start-recommended
	apt-get -y install apt-transport-https
	add-apt-repository -y "deb https://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main 9.6"
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
	apt-get update
	apt-get -y install postgresql-9.6
	service postgresql start
	#end-recommended
fi
