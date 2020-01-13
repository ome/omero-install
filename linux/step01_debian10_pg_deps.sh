#!/bin/bash

PGVER=${PGVER:-pg11}
if [[ "$PGVER" =~ ^(pg94|pg95|pg10)$ ]]; then
    PGVER="pg11"
fi

if [ "$PGVER" = "pg11" ]; then
    #start-recommended
    apt-get install -y postgresql-11
	service postgresql start
    #end-recommended
fi
