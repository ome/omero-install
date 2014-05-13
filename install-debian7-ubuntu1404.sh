dependencies-debian7-ubuntu1404.sh
settings.env

setup_postgres.sh

cd ~omero
sudo -iu omero bash setup_omero.sh

setup_nginx.sh

sudo -iu omero OMERO.server/bin/omero admin start
sudo -iu omero OMERO.server/bin/omero web start

setup_omero_daemon.sh

