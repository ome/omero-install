#!/bin/bash
PYTHONVER=${PYTHONVER:-default}

#start-add-dependencies
apt-get update
apt-get -y install \
	unzip \
	wget
#end-add-dependencies
if [ "$PYTHONVER" = "py36" ]; then
    #start-install-Python36
    apt-get install -y build-essential
    apt-get install -y zlib1g-dev libncurses5-dev libgdbm-dev \
                       libnss3-dev libssl-dev libreadline-dev libffi-dev
    # dependencies required to install Ice Python binding
    apt-get install -y libbz2-dev libxml2-dev libxslt1-dev
    cd /tmp
    wget https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tar.xz
    tar -xf Python-3.6.9.tar.xz
    cd Python-3.6.9
    ./configure --enable-optimizations
    make -j 1
    make altinstall
    #end-install-Python36                
else
    #start-default
    apt-get -y install python3 python3-venv
    #end-default
fi
