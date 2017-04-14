#!/bin/bash

WEBAPPS=${WEBAPPS:-false}
# dependency of the make movie scripts
apt-get -y install mencoder
# dependencies for the figure export script
if $WEBAPPS ; then
	apt-get -y install python-reportlab python-markdown
fi