#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
	sudo \
	python-{imaging,matplotlib,numpy,pip,scipy,tables,virtualenv} \
	openjdk-7-jre-headless \
	ice-services python-zeroc-ice \
	postgresql \
	nginx

service postgresql start

