#!/bin/bash

yum -y install python-{pip,devel,virtualenv,yaml,jinja2,tables}

if [[ ! "${container:-}" = docker ]]; then
	#start-docker-pip
	pip install --upgrade pip
	#end-docker-pip
fi

#start-web-dependencies
yum -y install python-pillow numpy
#end-web-dependencies
