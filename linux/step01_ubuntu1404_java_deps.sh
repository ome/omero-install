#!/bin/bash
JAVAVER=${JAVAVER:-open18}

# install java
if [ "$JAVAVER" = "open18" ]; then
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
elif [ "$JAVAVER" = "open17" ]; then
	apt-get -y install openjdk-7-jre-headless
fi