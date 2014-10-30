#!/bin/bash
su postgres -c 'pg_ctl -D /var/lib/pgsql/data -l /var/lib/pgsql/logfile start'
su - omero -c "OMERO.server/bin/omero admin start"
nginx
su - omero -c "OMERO.server/bin/omero web start"
bash
