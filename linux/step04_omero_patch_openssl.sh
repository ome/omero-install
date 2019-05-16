#!/bin/bash

#start-seclevel
OMERO.server/bin/omero config set omero.glacier2.IceSSL.Ciphers HIGH:ADH:@SECLEVEL=0
sed -i 's/\("IceSSL.Ciphers".*ADH\)/\1:@SECLEVEL=0/' OMERO.server/lib/python/omero/clients.py
#end-seclevel
#clean files
