#!/bin/bash

yum -y install \
	python27 \
	python27-devel \
	python27-yaml \
	python27-jinja2 \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	hdf5-devel \
	zlib-devel \
	freetype-devel

# install pip and virtualenv using Python 2.6 
yum -y install python-pip

pip install --upgrade virtualenv

#if virtualenv is not installed (unlikely)
#yum -y install python27-pip
#pip2.7 install virtualenv

# TODO: this installs a lot of unecessary packages:
yum -y groupinstall "Development Tools"

export PYTHONWARNINGS="ignore:Unverified HTTPS request"