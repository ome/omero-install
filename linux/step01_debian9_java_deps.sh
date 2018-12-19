#!/bin/bash
JAVAVER=${JAVAVER:-openjdk1.8}

# install java
if [ "$JAVAVER" = "openjdk1.8" ]; then
    #start-recommended
    apt-get -y install openjdk-8-jre-headless
    #end-recommended
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
   apt-get -y install openjdk-8-jdk
fi