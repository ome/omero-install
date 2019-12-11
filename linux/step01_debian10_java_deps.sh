#!/bin/bash
JAVAVER=${JAVAVER:-openjdk11}

# install java
if [ "$JAVAVER" = "openjdk11" ]; then
    #start-recommended
    apt-get -y install default-jre
    #end-recommended
elif [ "$JAVAVER" = "openjdk11-devel" ]; then
   apt-get -y install default-jdk
fi
