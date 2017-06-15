#!/bin/bash

PGVER=${PGVER:-pg96}

# Postgres installation
# 9.6
#start-recommended
apt-get -y install postgresql
service postgresql start
#end-recommended
