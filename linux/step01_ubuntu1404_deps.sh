#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
	python-{imaging,matplotlib,numpy,pip,scipy,tables,virtualenv} \
	openjdk-7-jre-headless \
	ice-services python-zeroc-ice \
	postgresql

# Django
pip install "Django<1.9"

service postgresql start
