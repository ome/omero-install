#!/bin/bash

dnf -y install python-{pip,devel,virtualenv,yaml,jinja2,tables}
dnf -y install /usr/bin/virtualenv

#start-web-dependencies
dnf -y install python-pillow numpy
#end-web-dependencies
