#!/bin/bash

PGVER=${PGVER:-pg94}

# Postgres installation
if [ "$PGVER" = "pg94" ]; then
	#start-recommended
	# Postgres, reconfigure to allow TCP connections
	yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm
	yum -y install postgresql94-server postgresql94

	PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-9.4/bin/postgresql94-setup initdb
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf

	#start-workaround to get postgresql running inside Docker
	if [ "${container:-}" = docker ]; then
	sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
        	/usr/lib/systemd/system/postgresql-9.4.service
	systemctl daemon-reload
	fi
	#end-workaround
	systemctl start postgresql-9.4.service
	systemctl enable postgresql-9.4.service
	#end-recommended
fi