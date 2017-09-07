#!/bin/bash

yum -y install redis-server

#start-web-dependencies
pip install django-redis>=4.4
#end-web-dependencies
systemctl enable redis-server.service
#start-check
if [ ! "${container:-}" = docker ]; then
    systemctl start redis-server.service
fi
#end-check