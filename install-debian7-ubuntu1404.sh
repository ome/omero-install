dependencies-debian7-ubuntu1404.sh
source settings.env

system_setup.sh
setup_postgres.sh

cd ~omero
sudo -iu omero bash setup_omero.sh

setup_nginx.sh

#sudo -iu omero OMERO.server/bin/omero admin start
#sudo -iu omero OMERO.server/bin/omero web start

setup_omero_daemon.sh

#service omero start
#service omero-web start

