#!/bin/bash
JAVAVER=${JAVAVER:-openjdk1.8}
# install java
if [ "$JAVAVER" = "openjdk1.8" ]; then
    #start-recommended
    apt-get -y install software-properties-common
    add-apt-repository -y ppa:openjdk-r/ppa
    apt-get update
    apt-get -y install openjdk-8-jre
    #end-recommended
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
    apt-get -y install software-properties-common
    add-apt-repository -y ppa:openjdk-r/ppa
    apt-get update
    apt-get -y install openjdk-8-jdk
elif [ "$JAVAVER" = "openjdk11-devel" ]; then
    apt-get -y install software-properties-common
    add-apt-repository ppa:openjdk-r/ppa
    apt-get update -q
    apt-get install -y openjdk-11-jdk
elif [ "$JAVAVER" = "openjdk11" ]; then
    apt-get -y install software-properties-common
    add-apt-repository ppa:openjdk-r/ppa
    apt-get update -q
    apt-get install -y openjdk-11-jre
fi
