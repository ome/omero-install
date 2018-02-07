#!/bin/bash

apt-get -y install \
	python-{pip,virtualenv,yaml,jinja2,setuptools,wheel}

apt-get -y install virtualenv

pip install --upgrade pip

# python-tables will install tables version 3.3
# but it does not work. install pytables from pypi.
pip install tables

#start-web-dependencies
apt-get -y install zlib1g-dev libjpeg-dev
apt-get -y install python-{pillow,numpy}
#end-web-dependencies