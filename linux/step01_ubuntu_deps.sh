#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
	python-{pip,pillow,numpy,scipy,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip

