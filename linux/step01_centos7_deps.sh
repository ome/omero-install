#!/bin/bash

yum -y install \
	python-pip python-devel python-virtualenv \
	numpy scipy python-matplotlib python-tables

# upgrade pip to run 7.1.2
pip install --upgrade pip

yum -y install \
	zlib-devel \
	libjpeg-devel \
	gcc

# Cap Pillow version due to a limitation in OMERO.figure with v3.0.0
pip install 'Pillow<3.0'

# Django
pip install 'Django>=1.8,<1.9'