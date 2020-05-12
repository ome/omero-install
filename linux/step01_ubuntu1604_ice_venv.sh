#!/bin/bash

set -x

PYTHONVER=${PYTHONVER:-default}
VENV_SERVER=${VENV_SERVER:-/opt/omero/server/venv3}
#start-ice-py

if [ "$PYTHONVER" = "py36" ]; then
    # start-py36
    # Create a virtual env and activate it
    python3.6 -mvenv $VENV_SERVER
    $VENV_SERVER/bin/pip install zeroc-ice==3.6.5
    # end-py36
else
    # start-default
    # Create a virtual env and activate it
    python3 -mvenv $VENV_SERVER

    # Install the Ice Python binding
    $VENV_SERVER/bin/pip install https://github.com/ome/zeroc-ice-py-ubuntu1604/releases/download/0.2.0/zeroc_ice-3.6.5-cp35-cp35m-linux_x86_64.whl
    # end-default
fi

# Install server dependencies
$VENV_SERVER/bin/pip install omero-server[ubuntu1604]
#end-ice-py
