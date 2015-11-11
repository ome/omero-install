#!/bin/sh

if [ $# -ne 1 ]; then
	echo "USAGE: `basename $0` distribution"
	exit 2
fi

set -e

rm -rf $1/omero-install-test
mkdir $1/omero-install-test
cp -a ../*.sh ../*.env ../*init.d ../*cron $1/omero-install-test

IMAGE=omero_install_test_${1%*/}
echo "Building image $IMAGE"
docker build -t $IMAGE $1
echo "Test this image by running docker run -it [...] $IMAGE"
