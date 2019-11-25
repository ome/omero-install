#!/bin/bash

set -e -u -x

ENV=${ENV:-centos7_nginx}
DMNAME=${DMNAME:-dev}
WEBSESSION=${WEBSESSION:-false}
VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}

. `pwd`/../settings.env
. `pwd`/../settings-web.env

CNAME=omeroinstall_$ENV

# start docker container
docker run -d --name $CNAME -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run -p 8080:80 omero_install_test_$ENV

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
            sleep 20; \
            d=$[$d -1]; \
            if [ $d -lt 0 ]; then \
                exit 1; \
            fi; \
        done;  \
    echo "Entry found"; exit'

#check OMERO.server service status
docker exec -it $CNAME /bin/bash -c "service omero status -l"

docker exec -it $CNAME /bin/bash -c "su - omero -c \". $VIRTUALENV/bin/activate;OMERODIR=/home/omero/OMERO.server omero admin diagnostics\""


# check OMERO.web status
docker exec -it $CNAME /bin/bash -c "service omero-web status -l"

if [[ "$WEBSESSION" = true ]]; then
    docker exec -it $CNAME /bin/bash -c "service redis status -l"
fi

# Log in to OMERO.server
docker exec -it $CNAME /bin/bash -c "su - omero -c \". $VIRTUALENV/bin/activate;OMERODIR=/home/omero/OMERO.server omero login -s localhost -p 4064 -u root -w ${OMERO_ROOT_PASS}\""

# Log in to OMERO.web
WEB_HOST=localhost:8080 ./test_login_to_web.sh

# stop and cleanup
docker stop $CNAME
docker rm $CNAME

# Sadly, no test for OS X here.
