#!/bin/bash

OMEROVER=${OMEROVER:-omero}

#start-install

# Install the OMERO dependencies in a virtual environment
# Create virtual env.
# -p only require if it has been installed with python 2.6

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u
/home/omero/omeroenv/bin/pip install --upgrade pip

/home/omero/omeroenv/bin/pip2.7 install -r requirements_centos6_py27_ius.txt

/home/omero/omeroenv/bin/pip2.7 install omego

deactivate