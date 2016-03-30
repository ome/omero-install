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

	URL=https://github.com/zeroc-ice/ice/archive/3.6.zip
	NAME_ZIP=${URL##*/}
	wget $URL
	unzip -q $NAME_ZIP
	rm $NAME_ZIP
	cd ice-3.6
	cd cpp
	make && make install
	cd ../python
	make && make install
	#zeroc-ice
	cd ../..
	
	# build zeroc-ice
	wget https://pypi.python.org/packages/source/z/zeroc-ice/zeroc-ice-3.6.1.zip#md5=a8c5a7782826c7b342e13c870ac59c7b
	unzip -q zeroc-ice-3.6.1.zip
	cd zeroc-ice-3.6.1
	python setup.py install
	# make path to Ice globally accessible
	# if globally set, there is no need to export LD_LIBRARY_PATH
	echo /opt/Ice-3.6.2/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
	echo /opt/Ice-3.6.2/lib > /etc/ld.so.conf.d/ice-x86_64.conf
	ldconfig
fi