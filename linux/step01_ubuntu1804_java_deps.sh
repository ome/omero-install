#!/bin/bash
JAVAVER=${JAVAVER:-openjdk1.8}

# install java
if [ "$JAVAVER" = "oracle11" ]; then
    apt-get -y install software-properties-common
    add-apt-repository ppa:linuxuprising/java
    apt-get update -q
    echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections
    apt-get install -y oracle-java11-installer
elif [ "$JAVAVER" = "openjdk11-devel" ]; then
    apt-get update -q
    apt-get install -y openjdk-11-jdk
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
    apt-get update -q
    apt-get install -y openjdk-8-jdk
elif [ "$JAVAVER" = "openjdk1.8" ]; then
    #start-recommended
    apt-get update -q
    apt-get install -y openjdk-8-jre
    #end-recommended
fi
