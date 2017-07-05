#!/bin/bash

ICEVER=${ICEVER:-ice36}


# Ice installation
if [ "$ICEVER" = "ice36" ]; then
	#start-recommended
 	apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev libdb-java
    apt-get -y install zeroc-ice-all-runtime
	pip install "zeroc-ice>3.5,<3.7"
	#end-recommended
fi