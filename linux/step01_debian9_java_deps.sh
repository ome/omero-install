#!/bin/bash
JAVAVER=${JAVAVER:-openjdk18}

# install java
if [ "$JAVAVER" = "openjdk18" ]; then
	#start-recommended
	apt-get -y install openjdk-8-jre-headless
	#end-recommended
elif [ "$JAVAVER" = "openjdk18-devel" ]; then
	apt-get -y install openjdk-8-jdk
fi