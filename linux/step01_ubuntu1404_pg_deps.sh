#!/bin/bash

PGVER=${PGVER:-pg94}

# Postgres installation
if [ "$PGVER" = "pg94" ]; then
	#start-recommended
	apt-get -y install postgresql-9.4
	service postgresql start
	#end-recommended
fi