#!/bin/bash

#start-recommended
cp omero-server-systemd.service /etc/systemd/system/omero-server.service
if [ ! -f /.dockerenv ]; then
    systemctl daemon-reload
fi
systemctl enable omero-server.service
#end-recommended
