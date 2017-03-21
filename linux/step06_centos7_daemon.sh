#!/bin/bash

#start-recommended
cp omero-systemd.service /etc/systemd/system/omero.service
cp omero-web-systemd.service /etc/systemd/system/omero-web.service
if [ ! "${container:-}" = docker ]; then
    systemctl daemon-reload
fi
systemctl enable omero.service
systemctl enable omero-web.service
#end-recommended
