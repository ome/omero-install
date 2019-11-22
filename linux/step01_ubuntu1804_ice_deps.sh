#!/bin/bash

ICEVER=${ICEVER:-ice36}

echo $ICEVER
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
    wget -q https://github.com/ome/zeroc-ice-ubuntu1804/releases/download/0.2.0/Ice-3.6.5-ubuntu1804-amd64.tar.gz
    tar xf Ice-3.6.5-ubuntu1804-amd64.tar.gz
    mv opt/Ice-3.6.5 /opt
    echo /opt/Ice-3.6.5/lib/x86_64-linux-gnu > /etc/ld.so.conf.d/ice-x86_64.conf
    ldconfig
    #end-recommended
fi

