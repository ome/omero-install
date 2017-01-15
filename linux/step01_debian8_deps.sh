#!/bin/bash

apt-get -y install \
	python-{pip,pillow,numpy,scipy,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip

pip install -r requirements.txt