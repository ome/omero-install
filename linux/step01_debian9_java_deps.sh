#!/bin/bash
JAVAVER=${JAVAVER:-openjdk1.8}

# install java
if [ "$JAVAVER" = "openjdk1.8" ]; then
    #start-recommended
    apt-get -y install openjdk-8-jre-headless
    #end-recommended
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
   apt-get -y install openjdk-8-jdk
elif [ "$JAVAVER" = "oracle11" ]; then
	apt-get -y install gnupg2 dirmngr
    echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | tee /etc/apt/sources.list.d/linuxuprising-java.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A
    apt-get update -q
    echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections
    apt-get -y install oracle-java11-installer
fi