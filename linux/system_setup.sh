#!/bin/bash

useradd -m omero
chmod a+X ~omero

echo source \~omero/omero-c6-py27.env >> ~omero/.bashrc

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"
