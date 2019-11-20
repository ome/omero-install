#!/bin/bash

apt-get -y install python3-{pip,virtualenv,yaml,jinja2}

# to be installed if recommended/suggested is false
apt-get -y install python3-setuptools python3-wheel virtualenv


# python-tables will install tables version 3.3
# but it does not work. install pytables from pypi.
pip install tables==3.4.4

#start-web-dependencies
apt-get -y install zlib1g-dev libjpeg-dev
apt-get -y install python3-{pillow,numpy}
#end-web-dependencies