#!/bin/bash

PGVER=${PGVER:-pg94}

# Postgres installation
if [ "$PGVER" = "pg94" ]; then
	#start-recommended
	apt-get -y install postgresql
	service postgresql start
	#end-recommended
fi