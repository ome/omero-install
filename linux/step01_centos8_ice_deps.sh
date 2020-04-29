#!/bin/bash

ICEVER=${ICEVER:-ice36}

# Ice installation
if [ "$ICEVER" = "ice36" ]; then
    #start-recommended
    yum install -y -q \
        bzip2-devel \
        expat-devel \
        gcc \
        gcc-c++ \
        libmcpp \
        openssl-devel \
        patch

    cd /tmp
    wget -q https://github.com/ome/zeroc-ice-centos8/releases/download/0.0.1/ice-3.6.5-0.0.1-centos8-amd64.tar.gz
    tar xf ice-3.6.5-0.0.1-centos8-amd64.tar.gz
    mv ice-3.6.5-0.0.1 ice-3.6.5
    mv ice-3.6.5 /opt
    echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
    ldconfig
    #end-recommended
fi