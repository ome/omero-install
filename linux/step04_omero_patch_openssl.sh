#!/bin/bash

. `dirname $0`/settings.env
#start-seclevel
omero config set omero.glacier2.IceSSL.Ciphers HIGH:ADH:@SECLEVEL=0
#end-seclevel
#clean files
