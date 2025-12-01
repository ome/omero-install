#!/bin/bash

set -e -u -x

#start-recommended
wget https://omero.readthedocs.io/en/stable/_downloads/08850daa9012dfe7b7d4a90dc76c1b83/omero-server-systemd.service -O /etc/systemd/system/omero-server.service
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
