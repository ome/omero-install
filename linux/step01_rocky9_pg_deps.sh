#!/bin/bash

# pg 13 is installed by default
yum -y install postgresql-server postgresql

ls -all /
if [ -f /.dockerenv ]; then
    su - postgres -c "/usr/bin/initdb -D /var/lib/pgsql/data --encoding=UTF8"
    echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf
else
    PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/bin/postgresql-setup --initdb
fi
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/data/pg_hba.conf

if [ -f /.dockerenv ]; then
    su - postgres -c "/usr/bin/pg_ctl start -D /var/lib/pgsql/data -w"
else
    systemctl start postgresql
fi
    systemctl enable postgresql

sed -i 's/ ident/ trust/g' /var/lib/pgsql/data/pg_hba.conf
