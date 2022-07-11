#!/bin/bash

PGVER=${PGVER:-pg11}


#start-postgresql-installation-general
yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
#end-postgresql-installation-general
if [ "$PGVER" = "pg11" ]; then
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
elif [ "$PGVER" = "pg13" ]; then
    yum -y install postgresql13-server postgresql13

    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-13/bin/initdb -D /var/lib/pgsql/13/data --encoding=UTF8"
        echo "listen_addresses='*'" >> /var/lib/pgsql/13/data/postgresql.conf
    else
        PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-13/bin/postgresql-13-setup initdb
    fi
    sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/13/data/pg_hba.conf
    if [ "${container:-}" = docker ]; then
        sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
        /usr/lib/systemd/system/postgresql-13.service
    fi
    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-13/bin/pg_ctl start -D /var/lib/pgsql/13/data -w"
    else
        systemctl start postgresql-13.service
    fi
    systemctl enable postgresql-13.service
elif [ "$PGVER" = "pg14" ]; then
    yum -y install postgresql14-server postgresql14

    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-14/bin/initdb -D /var/lib/pgsql/14/data --encoding=UTF8"
        echo "listen_addresses='*'" >> /var/lib/pgsql/14/data/postgresql.conf
    else
        PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-14/bin/postgresql-14-setup initdb
    fi
    sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/14/data/pg_hba.conf
    if [ "${container:-}" = docker ]; then
        sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
        /usr/lib/systemd/system/postgresql-14.service
    fi
    if [ "${container:-}" = docker ]; then
        su - postgres -c "/usr/pgsql-14/bin/pg_ctl start -D /var/lib/pgsql/14/data -w"
    else
        systemctl start postgresql-14.service
    fi
    systemctl enable postgresql-14.service
fi
