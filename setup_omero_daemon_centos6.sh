#!/bin/bash

cp omero-init.d /etc/init.d/omero
chmod a+x /etc/init.d/omero

cp omero-web-init.d /etc/init.d/omero-web
chmod a+x /etc/init.d/omero-web

if [ -f /usr/sbin/update-rc.d ]; then
    # Debian
    update-rc.d -f omero remove
    update-rc.d -f omero defaults 98 02
    update-rc.d -f omero-web remove
    update-rc.d -f omero-web defaults 98 02
elif [ -f /sbin/chkconfig ]; then
    # Redhat
    chkconfig --del omero
    chkconfig --add omero
    chkconfig --del omero-web
    chkconfig --add omero-web
else
    echo "ERROR: Failed to find init.d management script"
    exit 2
fi
