#!/bin/bash

OMEROVER=${OMEROVER:-omero}

# Install the OMERO dependencies in a virtual environment
# Create virtual env.
# -p only require if it has been installed with 2.6

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u
/home/omero/omeroenv/bin/pip install --upgrade pip

/home/omero/omeroenv/bin/pip2.7 install Pillow

# install omero dependencies
/home/omero/omeroenv/bin/pip2.7 install numpy matplotlib

# Django
/home/omero/omeroenv/bin/pip2.7 install "Django>=1.8,<1.9"

if [ $OMEROVER = omerodev ]; then
	/home/omero/omeroenv/bin/pip2.7 install omego
fi

deactivate