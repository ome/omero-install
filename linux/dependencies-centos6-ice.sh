#!/bin/bash

yum -y install tar

mkdir /tmp/ice
cd /tmp/ice

curl -Lo Ice-3.5.1.tar.gz https://zeroc.com/download/Ice/3.5/Ice-3.5.1.tar.gz

tar xvf Ice-3.5.1.tar.gz
cd Ice-3.5.1

cd cpp
make && make test && make install
cd ../py
set +u
source /opt/rh/python27/enable
set -u
make && make test && make install

