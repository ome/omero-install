#!/bin/bash

yum -y install redis python-redis

pip install "django-redis>=4.4,<4.9"

systemctl enable redis.service
if [ ! "${container:-}" = docker ]; then
    systemctl start redis.service
fi