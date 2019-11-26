#!/bin/bash

yum -y install python3-{pip,devel,virtualenv,yaml,jinja2,tables}


#start-web-dependencies
yum -y install numpy
#end-web-dependencies
