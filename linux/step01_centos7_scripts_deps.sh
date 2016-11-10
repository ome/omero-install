#!/bin/bash

WEBAPPS=${WEBAPPS:-false}
# dependency of the make movie scripts
rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum -y install mencoder
# dependencies for the figure export script
if $WEBAPPS ; then
	yum -y install python-reportlab python-markdown
fi