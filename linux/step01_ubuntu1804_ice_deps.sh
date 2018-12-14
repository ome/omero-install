#!/bin/bash

ICEVER=${ICEVER:-ice36}

# Ice 3.7
apt-get -y install gnupg2 software-properties-common
apt-key adv --keyserver keyserver.ubuntu.com --recv B6391CB2CFBA643D
apt-add-repository "deb http://zeroc.com/download/Ice/3.7/ubuntu18.04 stable main"
apt-get update
apt-get -y install zeroc-ice-all-runtime
