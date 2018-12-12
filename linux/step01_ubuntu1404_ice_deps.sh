#!/bin/bash

ICEVER=${ICEVER:-ice36}


# Ice installation
if [ "$ICEVER" = "ice36" ]; then

	#start-recommended
	# to be installed if recommended/suggested is false

	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E6DA83306132997
	apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main"
	apt-get update
	apt-get -y install zeroc-ice-all-runtime

	pip install https://github.com/ome/zeroc-ice-py-ubuntu1404/releases/download/0.1.0/zeroc_ice-3.6.4-cp27-none-linux_x86_64.whl
	#end-recommended
fi
