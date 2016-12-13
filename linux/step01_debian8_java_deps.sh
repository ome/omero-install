#!/bin/bash
JAVAVER=${JAVAVER:-openjdk18}

# install java
if [ "$JAVAVER" = "openjdk17" ]; then
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
elif [ "$JAVAVER" = "openjdk18" ]; then
	#start-recommended
	echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
	apt-get update
	apt-get -y install openjdk-8-jre-headless
	#end-recommended
elif [ "$JAVAVER" = "openjdk18-devel" ]; then
	echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
	apt-get update
	apt-get -y install openjdk-8-jdk
elif [ "$JAVAVER" = "openjdk17-devel" ]; then
	apt-get -y install openjdk-7-jdk
fi