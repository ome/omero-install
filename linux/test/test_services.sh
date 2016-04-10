#!/bin/bash

set -e -u -x

ENV=${ENV:-centos7_nginx}

source `pwd`/../settings.env

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

# check OMERO.web status
if [[ $ENV =~ "nginx" ]]; then
    docker exec -it $CNAME /bin/bash -c "service omero-web status -l"
fi
if [[ $ENV =~ "apache" ]]; then
    docker exec -it $CNAME /bin/bash -c "service httpd status -l"
fi

# Log in to OMERO.server
docker exec -it $CNAME /bin/bash -c "su - omero -c \"/home/omero/OMERO.server/bin/omero login -s localhost -p 4064 -u root -w ${OMERO_ROOT_PASS}\""

# Log in to OMERO.web
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
  DOCKER_IP=$(docker-machine ip omerodev)
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

# Sadly, no test for Windows or OS X here.