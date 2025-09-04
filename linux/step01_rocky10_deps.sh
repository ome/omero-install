#!/bin/bash

# General additional packages installation
#start-general
dnf -y install python3 unzip bzip2 tar wget bc openssl
#end-general

# Java installation
dnf -y install java-21-openjdk  # no other versions available

# ICE installation
#start-recommended-ice
if grep -q "Rocky" /etc/redhat-release; then
  dnf -y install 'dnf-command(config-manager)'
  dnf config-manager --set-enabled crb
fi
if grep -q "Red Hat" /etc/redhat-release; then
  subscription-manager repos --enable codeready-builder-for-rhel-10-$(arch)-rpms
fi
dnf install -y epel-release

dnf -y install expat libdb-cxx

cd /tmp
wget https://github.com/dominikl/zeroc-ice-rocky10-x86_64/releases/download/release-20250904145320/Ice-3.6.5-rocky10-x86_64.tar.gz
tar xf Ice-3.6.5-rocky10-x86_64.tar.gz
mv Ice-3.6.5 /opt/ice-3.6.5
echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
#end-recommended-ice
  
dnf -y install postgresql-server postgresql
if [ -f /.dockerenv ]; then
  su - postgres -c "/usr/bin/initdb -D /var/lib/pgsql/data --encoding=UTF8"
  echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf
else
  PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/bin/postgresql-setup --initdb
fi
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/data/pg_hba.conf
sed -i 's/ ident/ trust/g' /var/lib/pgsql/data/pg_hba.conf

if [ -f /.dockerenv ]; then
    su - postgres -c "/usr/bin/pg_ctl start -D /var/lib/pgsql/data -w"
else
    systemctl start postgresql
    systemctl enable postgresql
fi
