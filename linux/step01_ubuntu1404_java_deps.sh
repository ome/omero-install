#!/bin/bash
JAVAVER=${JAVAVER:-openjdk18}

# install java
if [ "$JAVAVER" = "openjdk18" ]; then
	#start-recommended
	apt-get -y install software-properties-common
	add-apt-repository -y ppa:openjdk-r/ppa
	apt-get update
	apt-get -y install openjdk-8-jre
	#end-recommended
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
elif [ "$JAVAVER" = "openjdk17" ]; then
	apt-get -y install openjdk-7-jre-headless
elif [ "$JAVAVER" = "openjdk17-devel" ]; then
	apt-get -y install openjdk-7-jdk
elif [ "$JAVAVER" = "openjdk18-devel" ]; then
	apt-get -y install software-properties-common
	add-apt-repository -y ppa:openjdk-r/ppa
	apt-get update
	apt-get -y install openjdk-8-jdk
elif [ "$JAVAVER" = "oracle19" ]; then
	apt-get -y install software-properties-common
	add-apt-repository -y ppa:webupd8team/java
	apt-get update
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	apt-get -y install oracle-java9-installer
fi
