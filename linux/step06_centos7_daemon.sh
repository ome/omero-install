#!/bin/bash

#start-recommended
cp omero-systemd.service /etc/systemd/system/omero.service
if [ ! "${container:-}" = docker ]; then
    systemctl daemon-reload
fi
systemctl enable omero.service
#end-recommended
