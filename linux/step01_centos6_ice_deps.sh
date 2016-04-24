#!/bin/bash

ICEVER=${ICEVER:-ice35}

# Ice installation
if [ "$ICEVER" = "ice35" ]; then
	#start-recommended
	curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

	yum -y install ice ice-python ice-servers
	#end-recommended
elif [ "$ICEVER" = "ice35-devel" ]; then
	curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

	yum -y install ice ice-python ice-java-devel ice-servers
elif [ "$ICEVER" = "ice36" ]; then
	#start-supported
	cd /etc/yum.repos.d
	wget https://zeroc.com/download/rpm/zeroc-ice-el6.repo

	yum -y install gcc-c++
	yum -y install db53 db53-utils
	yum -y install ice-all-runtime ice-all-devel

	yum -y install openssl-devel bzip2-devel expat-devel
	pip install "zeroc-ice>3.5,<3.7"
	#end-supported
fi