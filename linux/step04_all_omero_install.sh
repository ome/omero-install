#!/bin/bash

set -eux

. `dirname $0`/settings.env

#start-install-omero-py
# Install omero-py
$VENV_SERVER/bin/pip install "omero-py>=5.6.dev4"
