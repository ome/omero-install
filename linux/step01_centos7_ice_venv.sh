#!/bin/bash

set -e -u -x

VENV_SERVER=${VENV_SERVER:-/opt/omero/server/venv}
#start-ice-py
# Create a virtual env and activate it
python3 -mvenv $VENV_SERVER

# Install the Ice Python binding
$VENV_SERVER/bin/pip install https://github.com/ome/zeroc-ice-py-centos7/releases/download/0.2.1/zeroc_ice-3.6.5-cp36-cp36m-linux_x86_64.whl
#end-ice-py

VENV_WEB=${VENV_WEB:-/opt/omero/web/venv}
python3 -mvenv $VENV_WEB

# Install the Ice Python binding
$VENV_WEB/bin/pip install https://github.com/ome/zeroc-ice-py-centos7/releases/download/0.2.1/zeroc_ice-3.6.5-cp36-cp36m-linux_x86_64.whl
