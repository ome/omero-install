#!/bin/bash

set -e -u -x

VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}

#start-ice-py
# Create a virtual env
python3 -mvenv $VIRTUALENV
source $VIRTUALENV/bin/activate

# Install the Ice Python binding
pip3 install https://github.com/ome/zeroc-ice-ubuntu1804/releases/download/0.1.0/zeroc_ice-3.6.4-cp27-cp27mu-linux_x86_64.whl
