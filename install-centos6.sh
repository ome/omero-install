#!/bin/bash

bash -eux dependencies-centos6.sh
source settings.env

bash -eux system_setup.sh
bash -eux setup_postgres.sh

cd ~omero
sudo -iu omero bash -eux setup_omero_ice35.sh

bash -eux setup_nginx.sh

#sudo -iu omero OMERO.server/bin/omero admin start
#sudo -iu omero OMERO.server/bin/omero web start

bash -eux setup_omero_daemon.sh

#service omero start
#service omero-web start

