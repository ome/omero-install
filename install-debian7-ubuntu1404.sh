#!/bin/bash

set -e -u -x

# Full path of the current directory containing the install scripts
INSTALL_SCRIPTS=$(readlink -f $(dirname $0))

bash -eux dependencies-debian7-ubuntu1404.sh
source settings.env

bash -eux system_setup.sh
bash -eux setup_postgres.sh

cp settings.env setup_omero_ice35.sh ~omero
sudo -iu omero bash -eux setup_omero_ice35.sh

pushd ~omero
bash -eux $INSTALL_SCRIPTS/setup_nginx.sh
popd

#sudo -iu omero OMERO.server/bin/omero admin start
#sudo -iu omero OMERO.server/bin/omero web start

bash -eux setup_omero_daemon.sh

#service omero start
#service omero-web start

