#!/bin/bash

ICEVER=${ICEVER:-ice36}

# Ice installation
if [ "$ICEVER" = "ice36" ]; then
   #start-recommended
    curl -sL https://zeroc.com/download/Ice/3.6/el7/zeroc-ice3.6.repo > \
    /etc/yum.repos.d/zeroc-ice3.6.repo
    yum -y install gcc-c++
    yum -y install libdb-utils
    yum -y install openssl-devel bzip2-devel

    yum -y install ice-all-runtime

    pip3 install https://github.com/ome/zeroc-ice-py-centos7/releases/download/0.2.1/zeroc_ice-3.6.5-cp36-cp36m-linux_x86_64.whl
    # reset the locale
    localedef -i en_US -f UTF-8 en_US.UTF-8
elif [ "$ICEVER" = "ice36-devel" ]; then
    curl -sL https://zeroc.com/download/Ice/3.6/el7/zeroc-ice3.6.repo > \
    /etc/yum.repos.d/zeroc-ice3.6.repo
    yum -y install gcc-c++
    yum -y install libdb-utils
    yum -y install openssl-devel bzip2-devel

    yum -y install ice-all-runtime ice-all-devel

    pip3 install https://github.com/ome/zeroc-ice-py-centos7/releases/download/0.2.1/zeroc_ice-3.6.5-cp36-cp36m-linux_x86_64.whl 
    localedef -i en_US -f UTF-8 en_US.UTF-8
fi
