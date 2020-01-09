#!/bin/bash

#start-recommended
cp omero-server-init.d /etc/init.d/omero-server
chmod a+x /etc/init.d/omero-server

update-rc.d -f omero-server remove
update-rc.d -f omero-server defaults 98 02
#end-recommended
