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

    wget -q https://github.com/zeroc-ice/ice/archive/v3.6.4.tar.gz
    tar xzf v3.6.4.tar.gz
    cd ice-3.6.4/cpp
    
    make --silent && make install --silent

    pip install "zeroc-ice>3.5,<3.7"
    echo /opt/Ice-3.6.4/lib/x86_64-linux-gnu > /etc/ld.so.conf.d/ice-x86_64.conf
    ldconfig
    #end-recommended
fi

