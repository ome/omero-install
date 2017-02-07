#!/bin/bash
JAVAVER=${JAVAVER:-openjdk18}

# Java installation
if [ "$JAVAVER" = "openjdk17" ]; then
	yum -y install java-1.7.0-openjdk
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
elif [ "$JAVAVER" = "openjdk18" ]; then
	#start-recommended
	yum -y install java-1.8.0-openjdk
	#end-recommended
elif [ "$JAVAVER" = "openjdk18-devel" ]; then
	yum -y install java-1.8.0-openjdk-devel
elif [ "$JAVAVER" = "openjdk17-devel" ]; then
	yum -y install java-1.7.0-openjdk-devel
elif [ "$JAVAVER" = "oracle19" ]; then
	cd /opt
	wget --no-cookies \
	--no-check-certificate \
	--header "Cookie: oraclelicense=accept-securebackup-cookie" \
	"http://www.java.net/download/java/jdk9/archive/155/binaries/jdk-9-ea+155_linux-x64_bin.tar.gz" \
	-O jdk-9-linux-x64.tar.gz
	tar -zxvf jdk-9-linux-x64.tar.gz
	cd jdk-9
	alternatives --install /usr/bin/java java /opt/jdk-9/bin/java 2
	alternatives --install /usr/bin/jar jar /opt/jdk-9/bin/jar 2
	alternatives --install /usr/bin/javac javac /opt/jdk-9/bin/javac 2
	alternatives --set jar /opt/jdk-9/bin/jar
	alternatives --set javac /opt/jdk-9/bin/javac
fi