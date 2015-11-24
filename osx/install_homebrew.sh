#!/bin/bash

set -e -u -x

bash -eux step01_homebrew.sh
bash -eux step02_omero.sh