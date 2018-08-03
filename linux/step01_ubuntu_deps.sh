#!/bin/bash

apt-get update
apt-get -y install python-{pip,tables,virtualenv,yaml,jinja2}


#start-web-dependencies
apt-get -y install zlib1g-dev
apt-get -y install python-{pillow,numpy}
#end-web-dependencies
