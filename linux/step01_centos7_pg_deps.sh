#!/bin/bash

PGVER=${PGVER:-pg94}

# Postgres installation
if [ "$PGVER" = "pg94" ]; then
	# Postgres, reconfigure to allow TCP connections
	yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-3.noarch.rpm
	yum -y install postgresql94-server postgresql94

	if [ "${container:-}" = docker ]; then
		su - postgres -c "/usr/pgsql-9.4/bin/initdb -D /var/lib/pgsql/9.4/data --encoding=UTF8"
		echo "listen_addresses='*'" >> /var/lib/pgsql/9.4/data/postgresql.conf
	else
		PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-9.4/bin/postgresql94-setup initdb
	fi
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
	if [ "${container:-}" = docker ]; then
		sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
		/usr/lib/systemd/system/postgresql-9.4.service
	fi
	if [ "${container:-}" = docker ]; then
		su - postgres -c "/usr/pgsql-9.4/bin/pg_ctl start -D /var/lib/pgsql/9.4/data -w"
	else
		systemctl start postgresql-9.4.service
	fi
	systemctl enable postgresql-9.4.service
elif [ "$PGVER" = "pg95" ]; then
	# Postgres, reconfigure to allow TCP connections
	yum -y install http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-3.noarch.rpm
	yum -y install postgresql95-server postgresql95

	if [ "${container:-}" = docker ]; then
		su - postgres -c "/usr/pgsql-9.5/bin/initdb -D /var/lib/pgsql/9.5/data --encoding=UTF8"
		echo "listen_addresses='*'" >> /var/lib/pgsql/9.5/data/postgresql.conf
	else
		PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-9.5/bin/postgresql95-setup initdb
	fi
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.5/data/pg_hba.conf
	if [ "${container:-}" = docker ]; then
		sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
		/usr/lib/systemd/system/postgresql-9.5.service
	fi
	if [ "${container:-}" = docker ]; then
		su - postgres -c "/usr/pgsql-9.5/bin/pg_ctl start -D /var/lib/pgsql/9.5/data -w"
	else
		systemctl start postgresql-9.5.service
	fi
	systemctl enable postgresql-9.5.service
elif [ "$PGVER" = "pg96" ]; then
	#start-recommended
	# Postgres, reconfigure to allow TCP connections
	yum -y install http://yum.postgresql.org/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
	yum -y install postgresql96-server postgresql96

	if [ "${container:-}" = docker ]; then
		su - postgres -c "/usr/pgsql-9.6/bin/initdb -D /var/lib/pgsql/9.6/data --encoding=UTF8"
		echo "listen_addresses='*'" >> /var/lib/pgsql/9.6/data/postgresql.conf
	else
		PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-9.6/bin/postgresql96-setup initdb
	fi
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.6/data/pg_hba.conf
	if [ "${container:-}" = docker ]; then
		sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
		/usr/lib/systemd/system/postgresql-9.6.service
	fi
	if [ "${container:-}" = docker ]; then
		su - postgres -c "/usr/pgsql-9.6/bin/pg_ctl start -D /var/lib/pgsql/9.6/data -w"
	else
		systemctl start postgresql-9.6.service
	fi
	systemctl enable postgresql-9.6.service
	#end-recommended
elif [ "$PGVER" = "pg10" ]; then
    yum -y install https://yum.postgresql.org/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
    yum -y install postgresql10-server postgresql10

    if [ "${container:-}" = docker ]; then
		su - postgres -c "/usr/pgsql-10/bin/initdb -D /var/lib/pgsql/10/data --encoding=UTF8"
		echo "listen_addresses='*'" >> /var/lib/pgsql/10/data/postgresql.conf
	else
		PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-10/bin/postgresql10-setup initdb
	fi
	sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/10/data/pg_hba.conf
	if [ "${container:-}" = docker ]; then
		sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
		/usr/lib/systemd/system/postgresql-10.service
	fi
	if [ "${container:-}" = docker ]; then
		su - postgres -c "/usr/pgsql-10/bin/pg_ctl start -D /var/lib/pgsql/10/data -w"
	else
		systemctl start postgresql-10.service
	fi
	systemctl enable postgresql-10.service
fi
