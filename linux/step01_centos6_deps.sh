#!/bin/bash

yum -y install \
	python-pip python-devel python-virtualenv \
	numpy scipy python-matplotlib Cython \
	gcc \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	zlib-devel \
	hdf5-devel

# Requires gcc {libjpeg,libpng,libtiff,zlib}-devel
pip install 'Pillow<3.0'
pip install numexpr==1.4.2
# Requires gcc, Cython, hdf5-devel
pip install tables==2.4.0

# Django
pip install Django==1.6.11