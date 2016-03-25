#!/bin/bash

set -e -u -x

EXPERIMENTAL=${EXPERIMENTAL:-false}

bash -eux step01_deps.sh
bash -eux step02_omero.sh

if $EXPERIMENTAL ; then
    bash -eux step01_deps_experimental.sh
fi

bash -eux step03_nginx.sh
bash -eux step04_test.sh
