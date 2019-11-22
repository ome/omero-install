#!/bin/bash

set -e -u -x

VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}

#start-ice-py
# Create a virtual env
python3 -mvenv $VIRTUALENV
. $VIRTUALENV/bin/activate

# Install the Ice Python binding
pip3 install https://github.com/ome/zeroc-ice-py-ubuntu1804/releases/download/0.2.0/zeroc_ice-3.6.5-cp36-cp36m-linux_x86_64.whl
