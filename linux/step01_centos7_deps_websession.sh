#!/bin/bash

yum -y install redis python-redis

systemctl enable redis.service
if [ ! "${container:-}" = docker ]; then
    systemctl start redis.service
fi