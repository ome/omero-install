#!/bin/bash

PGVER=${PGVER:-pg11}


#required to install postgresql
rm -f /var/lib/rpm/__db*

#start-postgresql-installation-general
dnf module disable -y postgresql
yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
#end-postgresql-installation-general
if [ "$PGVER" = "pg96" ]; then
    # Postgres, reconfigure to allow TCP connections
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
elif [ "$PGVER" = "pg10" ]; then
    yum -y install postgresql10-server postgresql10

    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-10/bin/initdb -D /var/lib/pgsql/10/data --encoding=UTF8"
        echo "listen_addresses='*'" >> /var/lib/pgsql/10/data/postgresql.conf
    else
        PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-10/bin/postgresql-10-setup initdb
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
elif [ "$PGVER" = "pg11" ]; then
    #start-recommended
    yum -y install postgresql11-server postgresql11

    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-11/bin/initdb -D /var/lib/pgsql/11/data --encoding=UTF8"
        echo "listen_addresses='*'" >> /var/lib/pgsql/11/data/postgresql.conf
    else
        PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-11/bin/postgresql-11-setup initdb
    fi
    sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/11/data/pg_hba.conf
    if [ "${container:-}" = docker ]; then
        sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
        /usr/lib/systemd/system/postgresql-11.service
    fi
    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-11/bin/pg_ctl start -D /var/lib/pgsql/11/data -w"
    else
        systemctl start postgresql-11.service
    fi
    systemctl enable postgresql-11.service
    #end-recommended
elif [ "$PGVER" = "pg12" ]; then
    yum -y install postgresql12-server postgresql12

    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-12/bin/initdb -D /var/lib/pgsql/12/data --encoding=UTF8"
        echo "listen_addresses='*'" >> /var/lib/pgsql/12/data/postgresql.conf
    else
        PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-12/bin/postgresql-12-setup initdb
    fi
    sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/12/data/pg_hba.conf
    if [ "${container:-}" = docker ]; then
        sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
        /usr/lib/systemd/system/postgresql-12.service
    fi
    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-12/bin/pg_ctl start -D /var/lib/pgsql/12/data -w"
    else
        systemctl start postgresql-12.service
    fi
    systemctl enable postgresql-12.service
fi
