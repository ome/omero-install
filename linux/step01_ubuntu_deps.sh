#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
	python-{pip,pillow,numpy,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip

