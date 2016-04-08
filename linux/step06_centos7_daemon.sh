#!/bin/bash

PGVER=${PGVER:-pg94}

if [ "$PGVER" = "pg95" ]; then
	cp omero-pg95-systemd.service /etc/systemd/system/omero.service
elif [ "$PGVER" = "pg94" ]; then
	#start-recommended
	cp omero-systemd.service /etc/systemd/system/omero.service
	#end-recommended
fi

cp omero-web-systemd.service /etc/systemd/system/omero-web.service

systemctl daemon-reload

systemctl enable omero.service
systemctl enable omero-web.service
