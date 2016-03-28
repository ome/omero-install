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
	curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.6/el6/zeroc-ice-el6.repo

	yum -y groupinstall "Development tools"
	yum -y install openssl-devel bzip2-devel expat-devel
	yum -y install db53-devel db53-utils mcpp-devel
	yum -y install python-devel

	# Now install ice
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
	wget https://pypi.python.org/packages/source/z/zeroc-ice/zeroc-ice-3.6.1.zip#md5=a8c5a7782826c7b342e13c870ac59c7b
	unzip -q zeroc-ice-3.6.1.zip
	cd zeroc-ice-3.6.1
	python setup.py install

	echo /opt/Ice-3.6.2/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
	ldconfig
fi