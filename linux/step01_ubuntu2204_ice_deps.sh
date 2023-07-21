#!/bin/bash

ICEVER=${ICEVER:-ice36}

echo $ICEVER
# Ice installation
if [ "$ICEVER" = "ice36" ]; then
    #start-recommended
    apt-get update && \
    apt-get install -y -q \
        db5.3-util \
        bzip2 \
        libdb++ \
        libexpat1 \
        libmcpp0 \
        openssl \
        mcpp \
        zlib1g

    cd /tmp
    wget -q https://github.com/glencoesoftware/zeroc-ice-ubuntu2204-x86_64/releases/download/20221004/Ice-3.6.5-ubuntu2204-x86_64.tar.gz
    tar xf Ice-3.6.5-ubuntu2204-x86_64.tar.gz
    mv Ice-3.6.5 ice-3.6.5
    mv ice-3.6.5 /opt
    echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
    ldconfig
    #end-recommended
fi
