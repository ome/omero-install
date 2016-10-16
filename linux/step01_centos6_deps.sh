#!/bin/bash

yum -y install \
	python-pip python-devel python-virtualenv \
	python-yaml \
	numpy scipy python-matplotlib Cython \
	gcc \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	zlib-devel \
	hdf5-devel

# install dependencies using pip
# due to the fact that numexp must be installed before tables
# and due to limitation of pip.
while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ ! "$line" = \#* ]]; then
  	pip install $line
  fi
done < requirements_centos6.txt