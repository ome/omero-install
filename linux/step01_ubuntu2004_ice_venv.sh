#!/bin/bash

set -e -u -x

VENV_SERVER=${VENV_SERVER:-/opt/omero/server/venv3}
#start-ice-py
# Create a virtual env and activate it
python3 -mvenv $VENV_SERVER

# Install the Ice Python binding
$VENV_SERVER/bin/pip install https://github.com/ome/zeroc-ice-ubuntu2004/releases/download/0.2.0/zeroc_ice-3.6.5-cp38-cp38-linux_x86_64.whl

# Install pytables
$VENV_SERVER/bin/pip install tables

# Install omero-certificates
$VENV_SERVER/bin/pip install omero-certificates
#end-ice-py
