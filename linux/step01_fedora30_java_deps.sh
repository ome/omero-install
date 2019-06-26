#!/bin/bash
JAVAVER=${JAVAVER:-openjdk1.8}

# Java installation
if [ "$JAVAVER" = "openjdk1.8" ]; then
    #start-recommended
    dnf -y install java-1.8.0-openjdk
    #end-recommended
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
    dnf -y install java-1.8.0-openjdk-devel
fi
