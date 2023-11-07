#!/bin/bash

set -e -u -x

#start-recommended
cp omero-server-systemd.service /etc/systemd/system/omero-server.service
if [ ! -f /.dockerenv ]; then
    systemctl daemon-reload
fi
systemctl enable omero-server.service
#end-recommended


if [ ! -f /.dockerenv ]; then
  #start-open-omero-server-port
  firewall-cmd --zone=public --add-port=4064/tcp --permanent
  firewall-cmd --reload
  #end-open-omero-server-port
fi
