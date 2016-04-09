#!/bin/bash

set -e -u -x

source `pwd`/../settings.env

# start docker container
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
    docker run -d --privileged -p 8888:80 --name omeroinstall omero_install_test_$ENV
else
    docker run -d --name omeroinstall -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run omero_install_test_$ENV
fi

# check if container is running
docker inspect -f {{.State.Running}} omeroinstall

# wait for omero to start up and accept connections
docker exec -it omeroinstall /bin/bash -c 'until [ -f /home/omero/OMERO.server/var/log/Blitz-0.log ]; do sleep 5; done; echo "File found"; exit'
docker exec -it omeroinstall /bin/bash -c 'while ! grep "OMERO.blitz now accepting connections" /home/omero/OMERO.server/var/log/Blitz-0.log; do sleep 10; done'

#check OMERO.server service status
docker exec -it omeroinstall /bin/bash -c "service omero status -l"

# check OMERO.web status
if [[ $ENV =~ "nginx" ]]; then
    docker exec -it omeroinstall /bin/bash -c "service omero-web status -l"
fi
if [[ $ENV =~ "apache" ]]; then
    docker exec -it omeroinstall /bin/bash -c "service httpd status -l"
fi

# Log in to OMERO.server
docker exec -it omeroinstall /bin/bash -c "su - omero -c \"/home/omero/OMERO.server/bin/omero login -s localhost -p 4064 -u root -w ${OMERO_ROOT_PASS}\""

# Log in to OMERO.web
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
  curl -I http://$(docker-machine ip omerodev):8888/webclient
  WEB_HOST=$(docker-machine ip omerodev):8888 ./test_login_to_web.sh
else
  curl -I http://`docker inspect --format '{{ .NetworkSettings.IPAddress }}' omeroinstall`/webclient
  WEB_HOST=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' omeroinstall` ./test_login_to_web.sh
fi

# stop and cleanup
docker stop omeroinstall
docker rm omeroinstall

# Sadly, no test for Windows or OS X here.