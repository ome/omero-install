#!/bin/bash

ICEVER=${ICEVER:-ice35}

apt-cache search ice
# Ice installation
if [[ "$ICEVER" =~ "ice35" ]]; then
	#start-recommended
	apt-get -y install ice-services python-zeroc-ice
	#end-recommended
fi