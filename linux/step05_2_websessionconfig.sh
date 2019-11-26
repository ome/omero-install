#!/bin/bash

. `dirname $0`/settings.env

cd ~omero

pip3 install "django-redis>=4.10.0"

# Register the app
omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'
omero config set omero.web.caches '{\"default\": {\"BACKEND\": \"django_redis.cache.RedisCache\",\"LOCATION\": \"redis://127.0.0.1:6379/0\"}}'
