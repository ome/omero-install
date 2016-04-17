#!/bin/bash

yum -y install redis python-redis

pip install django-redis-cache>=1.6.5

systemctl enable redis.service
if [ ! "${container:-}" = docker ]; then
    systemctl start redis.service
fi