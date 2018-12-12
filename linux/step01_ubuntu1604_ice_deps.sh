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

	pip install https://github.com/ome/zeroc-ice-py-ubuntu1604/releases/download/0.1.0/zeroc_ice-3.6.4-cp27-cp27mu-linux_x86_64.whl
	#end-recommended
elif [ "$ICEVER" = "ice36-devel" ]; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E6DA83306132997
	apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main"
	apt-get update
	apt-get -y install zeroc-ice-all-runtime zeroc-ice-all-dev

	pip install https://github.com/ome/zeroc-ice-py-ubuntu1604/releases/download/0.1.0/zeroc_ice-3.6.4-cp27-cp27mu-linux_x86_64.whl
elif [ "$ICEVER" = "ice37" ]; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B6391CB2CFBA643D
	apt-add-repository "deb http://zeroc.com/download/Ice/3.7/ubuntu16.04 stable main"
	apt-get update
	apt-get -y install zeroc-ice-all-runtime
	apt-get -y install python-dev build-essential
	apt-get -y install db5.3-util
	apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev
	pip install "zeroc-ice>=3.7"
fi
