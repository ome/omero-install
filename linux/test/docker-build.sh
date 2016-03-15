#!/bin/sh

if [ $# -ne 1 ]; then
	echo "USAGE: `basename $0` distribution"
	exit 2
fi

WEBAPPS=${WEBAPPS:-false}
OMEROVER=${OMEROVER:-omero}
JAVAVER=${JAVAVER:-openjdk18}

set -e

rm -rf omero-install-test
mkdir omero-install-test
cp ../*.sh ../*.env ../*init.d ../*.service ../*cron omero-install-test
zip -r $1/omero-install-test.zip omero-install-test
rm -rf omero-install-test

IMAGE=omero_install_test_${1%*/}
echo "Building image $IMAGE"

if [[ $1 =~ "centos7" ]]; then
	docker build -t $IMAGE --no-cache $1
else
	docker build -t $IMAGE --no-cache --build-arg OMEROVER=${OMEROVER} \
	--build-arg JAVAVER=${JAVAVER} --build-arg WEBAPPS=${WEBAPPS} $1
fi
echo "Test this image by running docker run -it [...] $IMAGE"
