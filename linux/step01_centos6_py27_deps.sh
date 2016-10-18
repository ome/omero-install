#!/bin/bash

yum -y install \
	python27 \
	python27-virtualenv \
	python27-numpy \
	python27-yaml \
	python27-jinja2 \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	zlib-devel \
	hdf5-devel \
	freetype-devel \
	expat-devel

# TODO: this installs a lot of unecessary packages:
yum -y groupinstall "Development Tools"

set +u
source /opt/rh/python27/enable
set -u
easy_install pip

export PYTHONWARNINGS="ignore:Unverified HTTPS request"
pip install -r requirements_centos6_py27.txt