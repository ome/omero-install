#!/bin/bash

if [ $# -ne 1 ]; then
	echo "USAGE: `basename $0` distribution"
	exit 2
fi

WEBAPPS=${WEBAPPS:-false}
OMEROVER=${OMEROVER:-latest}
JAVAVER=${JAVAVER:-openjdk18}
ICEVER=${ICEVER:-ice35}
PGVER=${PGVER:-pg94}

WEBSESSION=${WEBSESSION:-false}

set -e

rm -rf omero-install-test
mkdir omero-install-test
cp ../*.sh ../*.env ../*init.d ../*.service ../*cron ../*.txt omero-install-test
zip -r $1/omero-install-test.zip omero-install-test
rm -rf omero-install-test

IMAGE=omero_install_test_${1%*/}
echo "Building image $IMAGE"

docker build -t $IMAGE --no-cache --build-arg OMEROVER=${OMEROVER} \
	--build-arg JAVAVER=${JAVAVER} --build-arg WEBAPPS=${WEBAPPS} \
    --build-arg ICEVER=${ICEVER} --build-arg PGVER=${PGVER} \
    --build-arg WEBSESSION=${WEBSESSION} $1

if [[ "$1" =~ "centos7" ]]; then
	echo "Test this image by running ./test_services.sh"
else
	echo "Test this image by running docker run -it [...] $IMAGE"
fi
