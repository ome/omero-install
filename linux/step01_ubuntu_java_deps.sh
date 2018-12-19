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
elif [ "$JAVAVER" = "oracle1.8" ]; then
    apt-get -y install software-properties-common
    add-apt-repository -y ppa:webupd8team/java
    apt-get update
    echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
    echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
    apt-get -y install oracle-java8-installer
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
elif [ "$JAVAVER" = "oracle11" ]; then
    apt-get -y install software-properties-common
    add-apt-repository ppa:linuxuprising/java
    apt-get update -q
    echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections
    apt-get install -y oracle-java11-installer
fi