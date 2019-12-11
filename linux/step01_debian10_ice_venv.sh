#!/bin/bash

set  -x

VENV_SERVER=${VENV_SERVER:-/opt/omero/server/venv3}
#start-ice-py
# Create a virtual env and activate it
python3 -mvenv $VENV_SERVER

# Install the Ice Python binding
$VENV_SERVER/bin/pip install https://github.com/jburel/zeroc-ice-py-debian10/releases/download/v0.1.1-rc1/zeroc_ice-3.6.5-cp37-cp37m-linux_x86_64.whl
#end-ice-py
