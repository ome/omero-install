#!/bin/bash

yum -y install postgresql-server postgresql
/usr/bin/postgresql-setup --initdb

sed -i 's/ ident/ trust/g' /var/lib/pgsql/data/pg_hba.conf

systemctl enable postgresql
systemctl start postgresql
