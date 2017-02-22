#!/bin/bash

PGVER=${PGVER:-pg94}

# Postgres installation
if [ "$PGVER" = "pg94" ]; then
	# Postgres, reconfigure to allow TCP connections
	yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-3.noarch.rpm
	yum -y install postgresql94-server postgresql94

	service postgresql-9.4 initdb
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
	chkconfig postgresql-9.4 on
	service postgresql-9.4 start
elif [ "$PGVER" = "pg95" ]; then
	# Postgres, reconfigure to allow TCP connections
	yum -y install http://yum.postgresql.org/9.5/redhat/rhel-6-x86_64/pgdg-centos95-9.5-3.noarch.rpm
	yum -y install postgresql95-server postgresql95

	service postgresql-9.5 initdb
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.5/data/pg_hba.conf
	chkconfig postgresql-9.5 on
	service postgresql-9.5 start
elif [ "$PGVER" = "pg96" ]; then
	#start-recommended
	# Postgres, reconfigure to allow TCP connections
	yum -y install http://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/pgdg-centos96-9.6-3.noarch.rpm
	yum -y install postgresql96-server postgresql96

	service postgresql-9.6 initdb
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.6/data/pg_hba.conf
	chkconfig postgresql-9.6 on
	service postgresql-9.6 start
	#end-recommended
fi
