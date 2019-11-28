#!/bin/bash

set -eux

. `dirname $0`/settings.env

# Install omero-py
pip install "omero-py>=5.6.dev4"
