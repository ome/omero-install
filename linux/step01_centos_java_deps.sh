#!/bin/bash
JAVAVER=${JAVAVER:-openjdk1.8}

# Java installation
if [ "$JAVAVER" = "oracle1.8" ]; then
   wget --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.rpm" \
    -O jdk-8-linux-x64.rpm
    yum -y localinstall jdk-8-linux-x64.rpm
elif [ "$JAVAVER" = "openjdk1.8" ]; then
    #start-recommended
    yum -y install java-1.8.0-openjdk
    #end-recommended
elif [ "$JAVAVER" = "openjdk1.8-devel" ]; then
    yum -y install java-1.8.0-openjdk-devel
elif [ "$JAVAVER" = "oracle11" ]; then
    wget --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "https://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_linux-x64_bin.rpm" \
    -O jdk-11-linux-x64.rpm
    yum -y localinstall jdk-11-linux-x64.rpm
fi