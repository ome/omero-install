#!/bin/bash

PGVER=${PGVER:-pg94}

# Postgres installation
if [ "$PGVER" = "pg94" ]; then
	#start-recommended
	# Postgres, reconfigure to allow TCP connections
	yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
	yum -y install postgresql94-server postgresql94

	service postgresql-9.4 initdb
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
	chkconfig postgresql-9.4 on
	service postgresql-9.4 start
	#end-recommended
fi