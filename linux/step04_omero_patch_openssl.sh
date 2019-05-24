#!/bin/bash

#start-seclevel
OMERO.server/bin/omero config set omero.glacier2.IceSSL.Ciphers HIGH:ADH:@SECLEVEL=0
#end-seclevel
#clean files
