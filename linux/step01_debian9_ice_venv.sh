#!/bin/bash

set  -x

VENV_SERVER=${VENV_SERVER:-/opt/omero/server/venv3}
#start-ice-py
# Create a virtual env
python3 -mvenv $VENV_SERVER

# Upgrade pip
$VENV_SERVER/bin/pip install --upgrade pip

# Install the Ice Python binding
$VENV_SERVER/bin/pip install https://github.com/ome/zeroc-ice-py-debian9/releases/download/0.2.0/zeroc_ice-3.6.5-cp35-cp35m-linux_x86_64.whl

# Install server dependencies
$VENV_SERVER/bin/pip install omero-server[debian9]
#end-ice-py
