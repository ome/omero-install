#!/bin/bash

apt-get -y install \
	python-{matplotlib,numpy,pip,scipy,tables,virtualenv}

# require to install Pillow
apt-get -y install \
	libtiff5-dev \
	libjpeg62-turbo-dev \
	zlib1g-dev \
	libfreetype6-dev \
	liblcms2-dev \
	libwebp-dev \
	tcl8.6-dev \
	tk8.6-dev

pip install -r requirements.txt