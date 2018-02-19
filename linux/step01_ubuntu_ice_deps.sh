#!/bin/bash

ICEVER=${ICEVER:-ice36}


# Ice installation
if [[ "$ICEVER" =~ "ice35" ]]; then
	#start-supported
	apt-get -y install ice-services python-zeroc-ice
	#end-supported
elif [ "$ICEVER" = "ice36" ]; then

	#start-recommended
	# to be installed if recommended/suggested is false
	apt-get -y install python-dev build-essential
	
	apt-get -y install db5.3-util
	apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev

	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E6DA83306132997
	apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main"
	apt-get update
	apt-get -y install zeroc-ice-all-runtime

	pip install "zeroc-ice>3.5,<3.7"
	#end-recommended
fi