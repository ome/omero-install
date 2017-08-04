#!/bin/bash

yum -y install \
	python-pip python-devel python-virtualenv \
	python-yaml python-jinja2 \
	python-pillow numpy python-tables

if [[ ! "${container:-}" = docker ]]; then
	#start-docker-pip
	pip install --upgrade pip
	#end-docker-pip
fi
