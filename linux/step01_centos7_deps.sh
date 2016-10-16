#!/bin/bash

yum -y install \
	python-pip python-devel python-virtualenv \
	python-yaml \
	numpy scipy python-matplotlib python-tables

yum -y install \
	zlib-devel \
	libjpeg-devel \
	gcc

if [[ ! "${container:-}" = docker ]]; then
	#start-docker-pip
	pip install --upgrade pip
	#end-docker-pip
fi

pip install -r `dirname $0`/requirements.txt