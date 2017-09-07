#!/bin/bash

yum -y install redis python-redis

#start-web-dependencies
pip install django-redis>=4.4
#end-web-dependencies
systemctl enable redis.service
#start-check
if [ ! "${container:-}" = docker ]; then
    systemctl start redis.service
fi
#end-check
