#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
	python-{pip,pillow,numpy,scipy,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip

# upgrade required since pillow is already installed
pip install --upgrade -r requirements.txt
