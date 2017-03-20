#!/bin/bash

yum -y install \
	python27 \
	python27-virtualenv \
	python27-numpy \
	python27-yaml \
	python27-jinja2 \
	hdf5-devel \
	expat-devel

yum -y install libjpeg-turbo zlib-devel

# TODO: this installs a lot of unecessary packages:
yum -y groupinstall "Development Tools"

set +u
source /opt/rh/python27/enable
set -u
easy_install pip

export PYTHONWARNINGS="ignore:Unverified HTTPS request"
pip install -r requirements_centos6_py27.txt