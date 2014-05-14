#!/bin/bash

apt-get -y install \
	unzip \
	wget \
	python-{imaging,matplotlib,numpy,pip,scipy,tables,virtualenv} \
	openjdk-7-jre-headless \
	zeroc-ice \
	postgresql \
	nginx

service postgresql start

