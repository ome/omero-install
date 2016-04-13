#!/bin/bash

ICEVER=${ICEVER:-ice35}

# Ice installation
if [[ "$ICEVER" =~ "ice35" ]]; then
	#start-recommended
	curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

	yum -y install db53 db53-utils mcpp
	mkdir /tmp/ice-download
	cd /tmp/ice-download

	wget http://downloads.openmicroscopy.org/ice/experimental/Ice-3.5.1-b1-centos6-iuspy27-x86_64.tar.gz

	tar -zxvf /tmp/ice-download/Ice-3.5.1-b1-centos6-iuspy27-x86_64.tar.gz

	# so we don't have to update ICE_HOME
	mv Ice-3.5.1-b1-centos6-iuspy27-x86_64 /opt/Ice-3.5.1

	# make path to Ice globally accessible
	# if globally set, there is no need to export LD_LIBRARY_PATH
	echo /opt/Ice-3.5.1/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
	ldconfig
	#end-recommended
elif [ "$ICEVER" = "ice36" ]; then
	curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.6/el6/zeroc-ice-el6.repo

	yum -y install git
	yum -y groupinstall "Development tools"
	yum -y install openssl-devel bzip2-devel expat-devel
	yum -y install db53-devel db53-utils mcpp-devel
	yum -y install python-devel

	# Now install ice
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

	virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
	set +u
	source /home/omero/omeroenv/bin/activate
	set -u

	# Install IcePy
	/home/omero/omeroenv/bin/pip2.7 install zeroc-ice

	deactivate
	
	echo /opt/Ice-3.6.2/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
	ldconfig
fi