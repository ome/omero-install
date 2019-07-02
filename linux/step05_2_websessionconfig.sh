#!/bin/bash

cd ~omero


# Register the app
su - omero -c "OMERO.server/bin/omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'"
su - omero -c "OMERO.server/bin/omero config set omero.web.caches '{\"default\": {\"BACKEND\": \"django_redis.cache.RedisCache\",\"LOCATION\": \"redis://127.0.0.1:6379/0\"}}'"
