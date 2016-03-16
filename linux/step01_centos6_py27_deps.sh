#!/bin/bash

yum -y install \
	python27 \
	python27-virtualenv \
	python27-numpy \
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
pip install tables matplotlib

# Cap Pillow version due to a limitation in OMERO.figure with v3.0.0
pip install "Pillow<3.0"

# Django
pip install "Django>=1.8,<1.9"