#!/bin/bash

yum -y install python-{pip,devel,virtualenv,yaml,jinja2,tables}


#start-web-dependencies
yum -y install python-pillow numpy
#end-web-dependencies
