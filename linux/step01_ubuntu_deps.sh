#!/bin/bash

apt-get update
apt-get -y install python3-{pip,tables,venv,yaml,jinja2}


#start-web-dependencies
apt-get -y install zlib1g-dev
apt-get -y install python3-{pillow,numpy}
#end-web-dependencies
