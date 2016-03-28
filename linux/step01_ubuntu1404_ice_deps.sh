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
	mkdir /tmp/ice-download
	cd /tmp/ice-download
	#to be modified and rename
	wget http://users.openmicroscopy.org.uk/~jburel/Ice-3.6.1-b1-ubuntu1404-amd64.tar.gz

	tar -zxvf /tmp/ice-download/Ice-3.6.1-b1-ubuntu1404-amd64.tar.gz

	# so we don't have to update ICE_HOME
	mv opt/Ice-3.6.1 /opt/Ice-3.6.2

	# make path to Ice globally accessible
	# if globally set, there is no need to export LD_LIBRARY_PATH
	echo /opt/Ice-3.6.2/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
	echo /opt/Ice-3.6.2/lib > /etc/ld.so.conf.d/ice-x86_64.conf
	ldconfig

	# build zeroc-ice
	wget https://pypi.python.org/packages/source/z/zeroc-ice/zeroc-ice-3.6.1.zip#md5=a8c5a7782826c7b342e13c870ac59c7b
	unzip -q zeroc-ice-3.6.1.zip
	cd zeroc-ice-3.6.1
	python setup.py install
fi