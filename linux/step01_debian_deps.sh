#!/bin/bash

apt-get -y install \
	python-{pip,pillow,numpy,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip
