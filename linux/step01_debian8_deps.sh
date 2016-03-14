#!/bin/bash
JAVAVER=${JAVAVER:-open18}

apt-get update
apt-get -y install \
	unzip \
	wget

#install java
if [ "$JAVAVER" = "open17" ]; then
	apt-get -y install openjdk-7-jre-headless
elif [ "$JAVAVER" = "oracle17" ]; then
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
	apt-get update
	echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
	apt-get -y install oracle-java7-installer
elif [ "$JAVAVER" = "oracle18" ]; then
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
	apt-get update
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
	apt-get -y install oracle-java8-installer
elif [ "$JAVAVER" = "open18" ]; then
	echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
	apt-get update
	apt-get -y install openjdk-8-jre-headless=8u66-b17-1~bpo8+1 ca-certificates-java=20140324
fi

apt-get -y install \
	python-{matplotlib,numpy,pip,scipy,tables,virtualenv}

apt-get -y install \
	ice-services python-zeroc-ice \
	postgresql

# require to install Pillow
apt-get -y install \
	libtiff5-dev \
	libjpeg62-turbo-dev \
	zlib1g-dev \
	libfreetype6-dev \
	liblcms2-dev \
	libwebp-dev \
	tcl8.6-dev \
	tk8.6-dev

pip install --upgrade "Pillow<3.0"

# Django
pip install "Django>=1.8,<1.9"

service postgresql start
