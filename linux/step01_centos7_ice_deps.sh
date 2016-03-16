#!/bin/bash

ICEVER=${ICEVER:-ice35}

# Ice installation
if [ "$ICEVER" = "ice35" ]; then
	#start-recommended
	curl -o /etc/yum.repos.d/zeroc-ice-el7.repo \
	http://download.zeroc.com/Ice/3.5/el7/zeroc-ice-el7.repo

	yum -y install ice ice-python ice-servers
	#end-recommended
elif [ "$ICEVER" = "ice35-devel" ]; then
	curl -o /etc/yum.repos.d/zeroc-ice-el7.repo \
	http://download.zeroc.com/Ice/3.5/el7/zeroc-ice-el7.repo

	yum -y install ice ice-python ice-java-devel ice-servers
fi