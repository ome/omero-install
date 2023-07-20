#!/bin/bash

set -x

. `dirname $0`/settings.env

#start-diffie-hellman
omero config set omero.glacier2.IceSSL.Ciphers=HIGH:!DH
#end-diffie-hellman