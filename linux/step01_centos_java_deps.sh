#!/bin/bash
JAVAVER=${JAVAVER:-open17}

# Java installation default Java openjdk 1.7
if [ "$JAVAVER" = "open18" ]; then
	yum -y install java-1.8.0-openjdk
elif [ "$JAVAVER" = "oracle17" ]; then
	wget --no-cookies \
	--no-check-certificate \
	--header "Cookie: oraclelicense=accept-securebackup-cookie" \
	"http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.rpm" \
	-O jdk-7-linux-x64.rpm
	yum -y localinstall jdk-7-linux-x64.rpm
elif [ "$JAVAVER" = "oracle18" ]; then
	wget --no-cookies \
	--no-check-certificate \
	--header "Cookie: oraclelicense=accept-securebackup-cookie" \
	"http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.rpm" \
	-O jdk-8-linux-x64.rpm
	yum -y localinstall jdk-8-linux-x64.rpm
else
	yum -y install java-1.7.0-openjdk
fi