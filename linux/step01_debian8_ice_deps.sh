#!/bin/bash

ICEVER=${ICEVER:-ice36}


# Ice installation
if [[ "$ICEVER" =~ "ice35" ]]; then
	#start-supported
	apt-get -y install ice-services python-zeroc-ice
 	#end-supported
elif [ "$ICEVER" = "ice36" ]; then
	#start-recommended
	mkdir /tmp/ice-download
	apt-get -y install python-dev
	apt-get -y install db5.3-util
 		 
 	apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev libdb-java	
 	cd /tmp/ice-download		
  		  
 	URL=https://github.com/zeroc-ice/ice/archive/v3.6.3.zip		 
 	NAME_ZIP=${URL##*/}	
 	wget $URL
 	unzip -q $NAME_ZIP
 	rm $NAME_ZIP		
 	cd ice-3.6.3/cpp		
 	make && make install

	pip install "zeroc-ice>3.5,<3.7"

	echo /opt/Ice-3.6.3/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf		
 	ldconfig
	#end-recommended
fi