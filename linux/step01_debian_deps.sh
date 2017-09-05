#!/bin/bash

apt-get -y install \
	python-{pip,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip

#start-web-dependencies
apt-get -y install zlib1g-dev libjpeg-dev
apt-get -y install python-{pillow,numpy}
#end-web-dependencies
