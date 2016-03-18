#!/bin/bash

yum -y install \
	python-pip python-devel python-virtualenv \
	numpy scipy python-matplotlib python-tables

yum -y install \
	zlib-devel \
	libjpeg-devel \
	gcc

pip install -r requirements.txt