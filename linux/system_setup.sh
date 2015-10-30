#!/bin/bash

useradd -m omero
chmod a+X ~omero

cat << EOF >> ~omero/.bashrc
source /opt/rh/python27/enable
ICE_HOME=/opt/Ice-3.5.1
PATH="\${ICE_HOME}/bin:$PATH"
export LD_LIBRARY_PATH="\${ICE_HOME}/lib64:\${ICE_HOME}/lib:\$LD_LIBRARY_PATH"
export PYTHONPATH="\${ICE_HOME}/python:\$PYTHONPATH"
export SLICEPATH="\${ICE_HOME}/slice"
EOF

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"
