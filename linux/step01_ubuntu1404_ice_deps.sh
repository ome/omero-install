#!/bin/bash

ICEVER=${ICEVER:-ice35}


# Ice installation
if [[ "$ICEVER" =~ "ice35" ]]; then
	#start-recommended
	apt-get -y install ice-services python-zeroc-ice
	#end-recommended
elif [ "$ICEVER" = "ice36" ]; then
	# install git to build omero
	apt-get -y install git

	apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev libdb-java
	mkdir /tmp/ice-download
	cd /tmp/ice-download

	URL=https://github.com/zeroc-ice/ice/archive/v3.6.2.zip
	NAME_ZIP=${URL##*/}
	wget $URL
	unzip -q $NAME_ZIP
	rm $NAME_ZIP
	cd ice-3.6.2
	cd cpp
	make && make install
	#zeroc-ice
	cd ../..
	
	# build zeroc-ice
	pip install zeroc-ice

	# make path to Ice globally accessible
	# if globally set, there is no need to export LD_LIBRARY_PATH
	echo /opt/Ice-3.6.2/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
	ldconfig
fi