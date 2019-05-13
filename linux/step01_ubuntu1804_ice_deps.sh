#!/bin/bash

ICEVER=${ICEVER:-ice36}

echo $ICEVER
# Ice installation
if [ "$ICEVER" = "ice36" ]; then
    #start-recommended
    apt-get update && \
    apt-get install -y -q\
        build-essential \
        db5.3-util \
        git \
        gpg-agent \
        libbz2-dev \
        libdb++-dev \
        libdb-dev \
        libexpat-dev \
        libmcpp-dev \
        libssl-dev \
        mcpp \
        python-dev \
        python-pip \
        software-properties-common \
        zlib1g-dev

    # Obtain BerekeleyDB and fix OpenSSL usage bug
    wget https://zeroc.com/download/berkeley-db/db-5.3.28.NC.tar.gz
    tar xzf db-5.3.28.NC.tar.gz
    wget https://zeroc.com/download/berkeley-db/berkeley-db.5.3.28.patch
    cd db-5.3.28.NC
    sed -i '2896i#if OPENSSL_VERSION_NUMBER < 0x10100000L' src/repmgr/repmgr_net.c
    sed -i '2906i#endif' src/repmgr/repmgr_net.c
    patch -p0 < ../berkeley-db.5.3.28.patch
    cd build_unix/
    ../dist/configure --enable-cxx --enable-java --prefix=/usr
    make
    make install
    # install mcpp version (maybe replace by package manager mcpp)
    cd ../..
    git clone https://github.com/zeroc-ice/mcpp.git
    cd mcpp
    make
    cd ..
    wget https://github.com/zeroc-ice/ice/archive/v3.6.4.tar.gz
    tar xzvf v3.6.4.tar.gz
    #git clone -b v3.6.4 https://github.com/zeroc-ice/ice.git
    cd ice-3.6.4
    sed -e "s/-Werror//g" -i ./cpp/config/Make.rules.Linux # Suppress -Werror flag (this may have uninteded consequences!!)
    make cpp java
    cd cpp 
    make install
    cd ../java
    make install
    echo /opt/Ice-3.6.4/lib > /etc/ld.so.conf.d/ice-x86_64.conf
    ldconfig
    pip install "zeroc-ice>3.5,<3.7"
    #end-recommended
fi

