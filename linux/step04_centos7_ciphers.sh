#!/bin/bash

set -x

#start-diffie-hellman
omero config set omero.glacier2.IceSSL.Ciphers=HIGH:!DH
#end-diffie-hellman