#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
	python3-{pip,tables,venv,yaml,jinja2}

# to be installed if recommended/suggested is false
apt-get -y install python3-setuptools python3-wheel

#start-web-dependencies
apt-get -y install zlib1g-dev
apt-get -y install python3-{pillow,numpy}
#end-web-dependencies
