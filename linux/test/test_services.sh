#!/bin/bash

set -e -u -x

ENV=${ENV:-centos7_nginx}
DMNAME=${DMNAME:-dev}
WEBSESSION=${WEBSESSION:-false}

source `pwd`/../settings.env
source `pwd`/../settings-web.env

CNAME=omeroinstall_$ENV

# start docker container
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
    docker run -d --privileged -p 8888:80 --name $CNAME omero_install_test_$ENV
else
    docker run -d --name $CNAME -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run omero_install_test_$ENV
fi

# check if container is running
docker inspect -f {{.State.Running}} $CNAME

# wait for omero to start up and accept connections
docker exec -it $CNAME /bin/bash -c 'd=10; \
    until [ -f /home/omero/OMERO.server/var/log/Blitz-0.log ]; \
        do \
            sleep 10; \
            d=$[$d -1]; \
            if [ $d -lt 0 ]; then \
                exit 1; \
            fi; \
        done; \
    echo "File found"; exit'

docker exec -it $CNAME /bin/bash -c 'd=10; \
    while ! grep "OMERO.blitz now accepting connections" /home/omero/OMERO.server/var/log/Blitz-0.log ; \
        do \
            sleep 10; \
            d=$[$d -1]; \
            if [ $d -lt 0 ]; then \
                exit 1; \
            fi; \
        done'

#check OMERO.server service status
docker exec -it $CNAME /bin/bash -c "service omero status -l"

docker exec -it $CNAME /bin/bash -c "su - omero -c \"/home/omero/OMERO.server/bin/omero admin diagnostics\""


# check OMERO.web status
docker exec -it $CNAME /bin/bash -c "service omero-web status -l"

if [[ "$WEBSESSION" = true ]]; then
    docker exec -it $CNAME /bin/bash -c "service redis status -l"
fi

# Log in to OMERO.server
docker exec -it $CNAME /bin/bash -c "su - omero -c \"/home/omero/OMERO.server/bin/omero login -s localhost -p 4064 -u root -w ${OMERO_ROOT_PASS}\""

# Log in to OMERO.web
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
  DOCKER_IP=$(docker-machine ip "${DMNAME}")
  curl -I http://${DOCKER_IP}:8888/webclient
  WEB_HOST="${DOCKER_IP}:8888" ./test_login_to_web.sh
else
  DOCKER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CNAME)
  curl -I http://${DOCKER_IP}/webclient
  WEB_HOST=$DOCKER_IP ./test_login_to_web.sh
fi

# stop and cleanup
docker stop $CNAME
docker rm $CNAME

# Sadly, no test for OS X here.
