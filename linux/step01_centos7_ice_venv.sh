#!/bin/bash

set -e -u -x

VENV_SERVER=${VENV_SERVER:-/opt/omero/server/venv3}
#start-ice-py
# Create a virtual env
/opt/rh/rh-python38/root/usr/bin/python -mvenv $VENV_SERVER

# Upgrade pip
$VENV_SERVER/bin/pip install --upgrade pip

# Install the Ice Python binding
$VENV_SERVER/bin/pip install https://github.com/ome/zeroc-ice-py-centos7/releases/download/0.3.0/zeroc_ice-3.6.5-cp38-cp38-linux_x86_64.whl

# Install server dependencies
$VENV_SERVER/bin/pip install omero-server[default]
#end-ice-py
