#!/bin/bash

ICEVER=${ICEVER:-ice36}


# Ice installation
if [ "$ICEVER" = "ice36" ]; then
    #start-recommended
    apt-get update && \
    apt-get install -y -q \
        build-essential \
        db5.3-util \
        libbz2-dev \
        libdb++-dev \
        libdb-dev \
        libexpat-dev \
        libmcpp-dev \
        libssl-dev \
        mcpp \
        zlib1g-dev

    cd /tmp
    wget -q https://github.com/ome/zeroc-ice-debian10/releases/download/0.1.0/ice-3.6.5-0.1.0-debian10-amd64.tar.gz
    tar xf ice-3.6.5-0.1.0-debian10-amd64.tar.gz
    mv ice-3.6.5-0.1.0 /opt
    echo /opt/ice-3.6.5-0.1.0/lib/x86_64-linux-gnu > /etc/ld.so.conf.d/ice-x86_64.conf
    ldconfig
    #end-recommended
fi
