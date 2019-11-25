#!/bin/bash

set  -x

#start-ice-py
# Create a virtual env and activate it
VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}
python3 -mvenv $VIRTUALENV
. $VIRTUALENV/bin/activate

# Install the Ice Python binding
pip3 install https://github.com/ome/zeroc-ice-py-debian9/releases/download/0.2.0/zeroc_ice-3.6.5-cp35-cp35m-linux_x86_64.whl
