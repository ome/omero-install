#!/bin/bash

PGVER=${PGVER:-pg10}

# Postgres installation
if [ "$PGVER" = "pg10" ]; then
    #start-recommended
    dnf -y install https://download.postgresql.org/pub/repos/yum/10/fedora/fedora-30-x86_64/pgdg-fedora-repo-42.0-4.noarch.rpm
    dnf -y install postgresql10-server postgresql10

    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-10/bin/initdb -D /var/lib/pgsql/10/data --encoding=UTF8"
        echo "listen_addresses='*'" >> /var/lib/pgsql/10/data/postgresql.conf
    else
        PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-10/bin/postgresql-10-setup initdb
    fi

    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-10/bin/pg_ctl start -D /var/lib/pgsql/10/data -w"
    else
        systemctl start postgresql-10.service
    fi
    systemctl enable postgresql-10.service

    #systemctl start postgresql-10.service
    #systemctl enable postgresql-10.service
    #end-recommended
fi
