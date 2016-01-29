#!/bin/bash
JAVAVER=${JAVAVER:-open17}

apt-get update
apt-get -y install \
	unzip \
	wget \
	python-{matplotlib,numpy,pip,scipy,tables,virtualenv}

#install java
if [ "$JAVAVER" = "open18" ]; then
	apt-get -y install software-properties-common
	add-apt-repository -y ppa:openjdk-r/ppa
	apt-get update
	apt-get -y install openjdk-8-jre
elif [ "$JAVAVER" = "oracle17" ]; then
	apt-get -y install software-properties-common
	add-apt-repository -y ppa:webupd8team/java
	apt-get update
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	apt-get -y install oracle-java7-installer
elif [ "$JAVAVER" = "oracle18" ]; then
	apt-get -y install software-properties-common
	add-apt-repository -y ppa:webupd8team/java
	apt-get update
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	apt-get -y install oracle-java8-installer
else
	apt-get -y install openjdk-7-jre-headless
fi

apt-get -y install \
	ice-services python-zeroc-ice \
	postgresql

# require to install Pillow
apt-get -y install \
	libtiff5-dev \
	libjpeg8-dev \
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
