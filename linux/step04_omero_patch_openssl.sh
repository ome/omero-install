#!/bin/bash

#start-seclevel
sed -i.bak 's/\("IceSSL.Ciphers".*ADH\)/\1:@SECLEVEL=0/' OMERO.server/lib/python/omero/clients.py OMERO.server/etc/templates/grid/templates.xml
#end-seclevel
#clean files
rm *.bak