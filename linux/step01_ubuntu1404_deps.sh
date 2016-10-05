#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
    git \
	python-{matplotlib,numpy,pip,scipy,tables,virtualenv}

# require to install Pillow
apt-get -y install \
	libtiff5-dev \
	libjpeg8-dev \
	zlib1g-dev \
	libfreetype6-dev \
	liblcms2-dev \
	libwebp-dev \
	tcl8.6-dev \
	tk8.6-dev

pip install --upgrade pip

# upgrade required since pillow is already installed
pip install --upgrade -r requirements.txt
