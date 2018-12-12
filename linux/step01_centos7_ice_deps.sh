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

    pip install "zeroc-ice>3.5,<3.7"
    #end-recommended
    # reset the locale
    localedef -i en_US -f UTF-8 en_US.UTF-8
elif [ "$ICEVER" = "ice36-devel" ]; then
    curl -sL https://zeroc.com/download/Ice/3.6/el7/zeroc-ice3.6.repo > \
    /etc/yum.repos.d/zeroc-ice3.6.repo
    yum -y install gcc-c++
    yum -y install libdb-utils
    yum -y install openssl-devel bzip2-devel

    yum -y install ice-all-runtime ice-all-devel

    pip install "zeroc-ice>3.5,<3.7"
    localedef -i en_US -f UTF-8 en_US.UTF-8
elif [ "$ICEVER" = "ice37" ]; then
    curl -sL https://zeroc.com/download/Ice/3.7/el7/zeroc-ice3.7.repo > \
    /etc/yum.repos.d/zeroc-ice3.7.repo
    yum -y install gcc-c++
    yum -y install libdb-utils
    yum -y install openssl-devel bzip2-devel

    yum -y install ice-all-runtime

    pip install "zeroc-ice>=3.7"
    localedef -i en_US -f UTF-8 en_US.UTF-8
elif [ "$ICEVER" = "ice37-devel" ]; then
    curl -sL https://zeroc.com/download/Ice/3.7/el7/zeroc-ice3.7.repo > \
    /etc/yum.repos.d/zeroc-ice3.7.repo
    yum -y install gcc-c++
    yum -y install libdb-utils
    yum -y install openssl-devel bzip2-devel

    yum -y install ice-all-runtime ice-all-devel

    pip install "zeroc-ice>=3.7"
    localedef -i en_US -f UTF-8 en_US.UTF-8
fi
