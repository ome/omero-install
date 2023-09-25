#!/bin/bash

# General additional packages installation
dnf -y install python unzip bzip2 wget bc openssl


# Java installation
JAVAVER=${JAVAVER:-openjdk11}
if [ "$JAVAVER" = "openjdk1.8" ]; then
    dnf -y install java-1.8.0-openjdk
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
    dnf -y install java-1.8.0-openjdk-devel
elif [ "$JAVAVER" = "openjdk11" ]; then
	#start-recommended
    dnf -y install java-11-openjdk
  #end-recommended
elif [ "$JAVAVER" = "openjdk11-devel" ]; then
    dnf -y install java-11-openjdk-devel
fi


# ICE installation
#start-recommended
if grep -q "Rocky" /etc/redhat-release; then
  dnf -y install 'dnf-command(config-manager)'
  dnf config-manager --set-enabled crb
fi
if grep -q "Red Hat" /etc/redhat-release; then
  subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
fi
dnf -y install expat libdb-cxx

cd /tmp
wget https://github.com/sbesson/zeroc-ice-rhel9-x86_64/releases/download/20230830/Ice-3.6.5-rhel9-x86_64.tar.gz
tar xf Ice-3.6.5-rhel9-x86_64.tar.gz
mv Ice-3.6.5 /opt/ice-3.6.5
echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
#end-recommended


# PostgreSQL installation
PGVER=${PGVER:-pg13} # pg 13 is installed by default
#start-recommended
dnf -y install postgresql-server postgresql

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
#end-recommended
