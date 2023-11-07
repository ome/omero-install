#!/bin/bash

PGVER=${PGVER:-pg15}
JAVAVER=${JAVAVER:-openjdk11}
# General additional packages installation
#start-general
dnf -y install python unzip bzip2 wget bc openssl
#end-general

# Java installation

if [ "$JAVAVER" = "openjdk1.8" ]; then
  dnf -y install java-1.8.0-openjdk
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
  dnf -y install java-1.8.0-openjdk-devel
elif [ "$JAVAVER" = "openjdk11" ]; then
  #start-recommended-java
  dnf -y install java-11-openjdk
  #end-recommended-java
elif [ "$JAVAVER" = "openjdk11-devel" ]; then
  dnf -y install java-11-openjdk-devel
fi


# ICE installation
#start-recommended-ice
if grep -q "Rocky" /etc/redhat-release; then
  dnf -y install 'dnf-command(config-manager)'
  dnf config-manager --set-enabled crb
fi
if grep -q "Red Hat" /etc/redhat-release; then
  subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
fi
dnf -y install expat libdb-cxx

cd /tmp
wget https://github.com/glencoesoftware/zeroc-ice-rhel9-x86_64/releases/download/20230928/Ice-3.6.5-rhel9-x86_64.tar.gz
tar xf Ice-3.6.5-rhel9-x86_64.tar.gz
mv Ice-3.6.5 /opt/ice-3.6.5
echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
#end-recommended-ice


# PostgreSQL installation
if [ "$PGVER" != "pg13" ]; then
  #start-pg-enabling
  dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
  dnf -qy module disable postgresql
  #end-pg-enabling
fi 

if [ "$PGVER" = "pg13" ]; then
  
  dnf -y install postgresql-server postgresql
  if [ -f /.dockerenv ]; then
    su - postgres -c "/usr/bin/initdb -D /var/lib/pgsql/data --encoding=UTF8"
    echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf
  else
    PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/bin/postgresql-setup --initdb
  fi
  sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/data/pg_hba.conf
  sed -i 's/ ident/ trust/g' /var/lib/pgsql/data/pg_hba.conf
  
elif [ "$PGVER" = "pg14" ]; then
  dnf -y install postgresql14-server postgresql14
  if [ -f /.dockerenv ]; then
    su - postgres -c "/usr/pgsql-14/bin/initdb -D /var/lib/pgsql/14/data --encoding=UTF8"
    echo "listen_addresses='*'" >> /var/lib/pgsql/14/data/postgresql.conf
    ln -s /usr/pgsql-14/bin/pg_ctl /usr/bin/pg_ctl
    ln -s /var/lib/pgsql/14/data /var/lib/pgsql/data
  else
    PGSETUP_INITDB_OPTIONS=--encoding=UTF8  /usr/pgsql-14/bin/postgresql-14-setup initdb
  fi

  sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/14/data/pg_hba.conf
  sed -i 's/ ident/ trust/g' /var/lib/pgsql/14/data/pg_hba.conf
elif [ "$PGVER" = "pg15" ]; then
  #start-recommended-postgres
  dnf -y install postgresql15-server postgresql15
  if [ -f /.dockerenv ]; then
    su - postgres -c "/usr/pgsql-15/bin/initdb -D /var/lib/pgsql/15/data --encoding=UTF8"
    echo "listen_addresses='*'" >> /var/lib/pgsql/15/data/postgresql.conf
    ln -s /usr/pgsql-15/bin/pg_ctl /usr/bin/pg_ctl
    ln -s /var/lib/pgsql/15/data /var/lib/pgsql/data
  else
    PGSETUP_INITDB_OPTIONS=--encoding=UTF8  /usr/pgsql-15/bin/postgresql-15-setup initdb
  fi
  sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/15/data/pg_hba.conf
  sed -i 's/ ident/ trust/g' /var/lib/pgsql/15/data/pg_hba.conf
  #end-recommended-postgres
elif [ "$PGVER" = "pg16" ]; then
  dnf -y install postgresql16-server postgresql16
    if [ -f /.dockerenv ]; then
    su - postgres -c "/usr/pgsql-16/bin/initdb -D /var/lib/pgsql/16/data --encoding=UTF8"
    echo "listen_addresses='*'" >> /var/lib/pgsql/16/data/postgresql.conf
    ln -s /usr/pgsql-16/bin/pg_ctl /usr/bin/pg_ctl
    ln -s /var/lib/pgsql/16/data /var/lib/pgsql/data
  else
    PGSETUP_INITDB_OPTIONS=--encoding=UTF8  /usr/pgsql-16/bin/postgresql-16-setup initdb
  fi

  sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/16/data/pg_hba.conf
  sed -i 's/ ident/ trust/g' /var/lib/pgsql/16/data/pg_hba.conf
fi

if [ -f /.dockerenv ]; then
    su - postgres -c "/usr/bin/pg_ctl start -D /var/lib/pgsql/data -w"
else
    if [ "$PGVER" = "pg13" ]; then
        #start-recommended-pg-start
        systemctl start postgresql
        systemctl enable postgresql
        #end-recommended-pg-start
    elif [ "$PGVER" = "pg14" ]; then
        systemctl start postgresql-14
        systemctl enable postgresql-14
    elif [ "$PGVER" = "pg15" ]; then
        systemctl start postgresql-15
        systemctl enable postgresql-15
    elif [ "$PGVER" = "pg16" ]; then
        systemctl start postgresql-16
        systemctl enable postgresql-16
    fi
fi
