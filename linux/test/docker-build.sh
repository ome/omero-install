#!/bin/sh

if [ $# -ne 1 ]; then
	echo "USAGE: `basename $0` distribution"
	exit 2
fi

set -e

rm -rf omero-install-test
mkdir omero-install-test
cp ../*.sh ../*.env ../*init.d omero-install-test
zip -r $1/omero-install-test.zip omero-install-test
rm -rf omero-install-test

IMAGE=omero_install_test_${1%*/}
echo "Building image $IMAGE"
docker build -t $IMAGE --no-cache $1
echo "Test this image by running docker run -it [...] $IMAGE"

