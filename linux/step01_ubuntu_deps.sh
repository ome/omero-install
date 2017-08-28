#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
	python-{pip,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip

#start-web-dependencies
apt-get -y install python-{pillow,numpy}
#end-web-dependencies
