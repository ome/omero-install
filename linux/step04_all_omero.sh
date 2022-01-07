#!/bin/bash

set -x

. `dirname $0`/settings.env

# Create the conda environment
$CONDA_ENV/bin/conda create --name venv3 python=3.9 pip

# Install omero-py
$CONDA_ENV/bin/conda install -n venv3 -c ome omero-py

# Install server dependencies
$CONDA_ENV/envs/venv3/bin/pip install omero-server[default]

#configure
omero config set omero.data.dir "$OMERO_DATA_DIR"
omero config set omero.db.name "$OMERO_DB_NAME"
omero config set omero.db.user "$OMERO_DB_USER"
omero config set omero.db.pass "$OMERO_DB_PASS"
#start-db

#start-deb-latest
omero db script -f $OMERODIR/db.sql --password "$OMERO_ROOT_PASS"
#end-deb-latest

#start-seclevel
omero certificates
#end-seclevel
