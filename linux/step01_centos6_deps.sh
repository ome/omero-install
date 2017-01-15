#!/bin/bash

yum -y install \
	python-pip python-devel python-virtualenv \
	python-yaml python-jinja2 \
	numpy scipy Cython \
	gcc \
	hdf5-devel

# install dependencies using pip
# due to the fact that numexp must be installed before tables
# and due to limitation of pip.
while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ ! "$line" = \#* ]]; then
  	pip install $line
  fi
done < requirements_centos6.txt