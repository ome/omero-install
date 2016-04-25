#!/bin/bash

ICEVER=${ICEVER:-ice35}


# Ice installation
if [[ "$ICEVER" =~ "ice35" ]]; then
	#start-recommended
	apt-get -y install ice-services python-zeroc-ice
	#end-recommended
elif [ "$ICEVER" = "ice36" ]; then
	#start-supported
	apt-get -y install db5.3-util
	apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev

	apt-key adv --keyserver keyserver.ubuntu.com --recv 5E6DA83306132997
	apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main"
	apt-get update
	apt-get -y install zeroc-ice-all-runtime zeroc-ice-all-dev

	pip install "zeroc-ice>3.5,<3.7"
	#end-supported
fi