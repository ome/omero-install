#!/bin/bash

VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}

export OMERODIR=/home/omero/OMERO.server

#start-seclevel
. $VIRTUALENV/bin/activate
omero config set omero.glacier2.IceSSL.Ciphers HIGH:ADH:@SECLEVEL=0
#end-seclevel
#clean files
