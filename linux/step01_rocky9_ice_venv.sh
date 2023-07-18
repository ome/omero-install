#!/bin/bash

set -e -u -x

VENV_SERVER=${VENV_SERVER:-/opt/omero/server/venv3}
#start-ice-py
# Create a virtual env
python -mvenv $VENV_SERVER

# Upgrade pip
$VENV_SERVER/bin/pip install --upgrade pip

# Install the Ice Python binding
$VENV_SERVER/bin/pip install https://github.com/sbesson/zeroc-ice-py-rockylinux9-x86_64/releases/download/20230719/zeroc_ice-3.6.5-cp39-cp39-linux_x86_64.whl

# Install server dependencies
$VENV_SERVER/bin/pip install omero-server
#end-ice-py
