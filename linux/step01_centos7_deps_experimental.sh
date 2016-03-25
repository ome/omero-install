#!/bin/bash

yum -y install redis python-redis

pip install django-redis-cache>=1.6.5