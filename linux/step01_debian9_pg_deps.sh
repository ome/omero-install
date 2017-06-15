#!/bin/bash

PGVER=${PGVER:-pg96}

# Postgres installation
if [ "$PGVER" = "pg96" ]; then
	#start-recommended
	apt-get -y install postgresql
	service postgresql start
	#end-recommended
fi