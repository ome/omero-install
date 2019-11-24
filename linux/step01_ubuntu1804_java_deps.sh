#!/bin/bash
JAVAVER=${JAVAVER:-openjdk1.8}

# install java
if [ "$JAVAVER" = "openjdk11-devel" ]; then
    apt-get update -q
    apt-get install -y openjdk-11-jdk
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
    apt-get update -q
    apt-get install -y openjdk-8-jdk
elif [ "$JAVAVER" = "openjdk11" ]; then
    apt-get update -q
    apt-get install -y openjdk-11-jre
elif [ "$JAVAVER" = "openjdk1.8" ]; then
    #start-recommended
    apt-get update -q
    apt-get install -y openjdk-8-jre
    #end-recommended
fi
